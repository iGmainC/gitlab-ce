FROM gitlab/gitlab-ce:latest

RUN curl -fsSL https://tailscale.com/install.sh | sh
RUN touch /start.sh && chmod +x /start.sh \
 && echo "tailscaled --state=/state/tailscaled.state --statedir=/state/ &" > /start.sh \
 && echo "sleep 10" >> /start.sh \
 && echo "tailscale up" >> /start.sh \
 && echo "/assets/wrapper" >> /start.sh

VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab", "/state"]

CMD ["bash", "/start.sh"]

HEALTHCHECK --interval=60s --timeout=30s --retries=5 \
CMD /opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10

