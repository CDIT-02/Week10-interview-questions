# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set environment variables
ENV APP_ENV=production

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    vim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app


COPY indx.html .

# Expose port 5000
EXPOSE 5000 

CMD ["python", "app.py"]
