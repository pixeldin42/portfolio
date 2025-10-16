# Use official Nginx image
FROM nginx:alpine

# Copy your static website to nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
