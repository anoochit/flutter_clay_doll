# Stage 1: Build the Flutter web app
FROM cirrusci/flutter:stable AS builder

# Set the working directory
WORKDIR /app

# Copy the Flutter project files
COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Build the web application
RUN flutter build web

# Stage 2: Serve the web app with Nginx
FROM nginx:alpine

# Copy the built web app from the builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80