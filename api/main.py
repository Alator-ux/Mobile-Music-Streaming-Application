import os
import jwt
from datetime import datetime, timedelta
from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException, Depends
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import psycopg2
from psycopg2.extras import RealDictCursor

load_dotenv()

app = FastAPI(title="Music Streaming API")
script_dir = os.path.dirname(__file__)
rel_path = "../database/tracks"
abs_file_path = os.path.join(script_dir, rel_path)

app.mount("/tracks", StaticFiles(directory=abs_file_path), name="tracks")

# Конфигурация БД
DB_CONFIG = {
    "host": os.getenv("POSTGRES_HOST", "localhost"), 
    "port": os.getenv("POSTGRES_PORT", "5432"),      
    "user": os.getenv("POSTGRES_USER"),
    "password": os.getenv("POSTGRES_PASSWORD"),
    "dbname": os.getenv("POSTGRES_DB")
}

# Настройки JWT
SECRET_KEY = os.getenv("JWT_SECRET", "super-secret-key-for-study-123456789")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24 * 7


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

class UserRegister(BaseModel):
    email: str
    password: str
    name: str

def get_db_connection():
    try:
        conn = psycopg2.connect(**DB_CONFIG, cursor_factory=RealDictCursor)
        return conn
    except Exception as e:
        print(f"Ошибка подключения к БД: {e}")
        raise HTTPException(status_code=500, detail="Database connection failed")

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=401,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id = payload.get("sub")
        if user_id is None:
            print("Ошибка: В токене нет поля sub!")
            raise credentials_exception
        return str(user_id)
    except jwt.ExpiredSignatureError:
        print("Ошибка: Токен протух!")
        raise credentials_exception
    except jwt.PyJWTError as e:
        # ВОТ ТУТ МЫ УВИДИМ РЕАЛЬНУЮ ПРИЧИНУ В КОНСОЛИ
        print(f"Ошибка декодирования токена: {e}") 
        raise credentials_exception


@app.post("/register", tags=["Auth"])
def register(user: UserRegister):
    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("SELECT id FROM users WHERE email = %s;", (user.email,))
    if cur.fetchone():
        cur.close()
        conn.close()
        raise HTTPException(status_code=400, detail="Email already registered")
        
    cur.execute(
        "INSERT INTO users (email, password, name) VALUES (%s, %s, %s) RETURNING id, email, name;",
        (user.email, user.password, user.name)
    )
    new_user = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()
    
    return {"message": "User created successfully", "user": new_user}

@app.post("/login", tags=["Auth"])
def login(form_data: OAuth2PasswordRequestForm = Depends()):

    conn = get_db_connection()
    cur = conn.cursor()
    
    cur.execute("SELECT * FROM users WHERE email = %s;", (form_data.username,))
    user = cur.fetchone()
    cur.close()
    conn.close()
    
    if not user or user["password"] != form_data.password:
        raise HTTPException(status_code=400, detail="Incorrect email or password")
        
    access_token = create_access_token(data={"sub": str(user["id"])})
    
    return {"access_token": access_token, "token_type": "bearer", "user": {
            "name": user["name"],
            "email": user["email"]
        }}

@app.get("/users/me", tags=["Users"])
def get_my_profile(current_user_id: str = Depends(get_current_user)):

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT id, email, name, created_at FROM users WHERE id = %s;", (current_user_id,))
    user = cur.fetchone()
    cur.close()
    conn.close()
    
    return user

# --- ПУБЛИЧНЫЕ РОУТЫ (без изменений) ---

@app.get("/tracks", tags=["Music"])
def get_tracks():
    conn = get_db_connection()
    cur = conn.cursor()
    query = """
        SELECT 
            t.*, 
            ARRAY_AGG(a.name) as artists
        FROM tracks t
        LEFT JOIN track_artists ta ON t.id = ta.track_id
        LEFT JOIN artists a ON ta.artist_id = a.id
        GROUP BY t.id;
    """
    cur.execute(query)
    tracks = cur.fetchall()
    cur.close()
    conn.close()
    return {"tracks": tracks}

@app.get("/artists", tags=["Music"])
def get_artists():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM artists;")
    artists = cur.fetchall()
    cur.close()
    conn.close()
    return {"artists": artists}

@app.get("/genres", tags=["Music"])
def get_genres():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM genres;")
    genres = cur.fetchall()
    cur.close()
    conn.close()
    return {"genres": genres}