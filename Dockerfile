FROM        alpine

LABEL       maintainer="https://github.com/hermsi1337"

ENV         CONF_VOLUME="/conf.d"
ENV         OPENSSH_VERSION="${OPENSSH_VERSION}" \
            CACHED_SSH_DIRECTORY="${CONF_VOLUME}/ssh" \
            AUTHORIZED_KEYS_VOLUME="${CONF_VOLUME}/authorized_keys" \
            ROOT_KEYPAIR_LOGIN_ENABLED="false" \
            ROOT_LOGIN_UNLOCKED="false" \
            USER_LOGIN_SHELL="/bin/ash" \
            USER_LOGIN_SHELL_FALLBACK="/bin/ash"

RUN         apk add --upgrade --no-cache \
                    openssh \
            && \
            mkdir -p /root/.ssh "${CONF_VOLUME}" "${AUTHORIZED_KEYS_VOLUME}" \
            && \
            cp -a /etc/ssh "${CACHED_SSH_DIRECTORY}" \
            && \
            rm -rf /var/cache/apk/*

COPY        entrypoint.sh /
EXPOSE      22
VOLUME      ["/etc/ssh"]
ENTRYPOINT  ["/entrypoint.sh"]
