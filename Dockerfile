# Use the official Python image from the Docker Hub
FROM python:3.10-slim

# Set environment variables to avoid creating .pyc files and to buffer stdout/stderr (useful for debugging)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev gcc

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the current project files into the container
COPY . /app/

# Expose the port Django will run on
EXPOSE 8000

# Start Django server (to be overridden in docker-compose.yml for migrations and other commands)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
