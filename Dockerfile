# Use the official launcher image which bundles both PicoClaw and the React WebUI
FROM sipeed/picoclaw:launcher

# Render injects a dynamic PORT variable. We instruct PicoClaw to listen on it.
# We also use -public to ensure the WebUI accepts traffic outside localhost.
ENV PICOCLAW_LAUNCHER_PORT=10000
ENV PICOCLAW_GATEWAY_HOST=0.0.0.0

# Expose the standard Render fallback port 
EXPOSE 10000

# Start the launcher pointing to the active environment port
CMD ["sh", "-c", "/app/picoclaw-launcher -port ${PORT:-10000} -public"]
