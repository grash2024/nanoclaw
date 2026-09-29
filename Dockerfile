FROM sipeed/picoclaw:launcher

# Force the launcher to listen globally
ENV PICOCLAW_LAUNCHER_HOST=0.0.0.0
ENV PICOCLAW_GATEWAY_HOST=0.0.0.0

# Render default fallback port
EXPOSE 10000

# Explicitly bind to the lowercase port argument using Render's exact environment variable
CMD ["sh", "-c", "/app/picoclaw-launcher -port ${PORT} -public"]
