FROM mageai/mageai:latest

ARG PROJECT_NAME=[demo_mage]
ARG MAGE_CODE_PATH=/home/mage_code
ARG USER_CODE_PATH=${MAGE_CODE_PATH}/${PROJECT_NAME}

WORKDIR ${MAGE_CODE_PATH}

COPY ${PROJECT_NAME} ${PROJECT_NAME}

ENV USER_CODE_PATH=${USER_CODE_PATH}

RUN \
  pip3 install --no-cache-dir "git+https://github.com/wbond/oscrypto.git@d5f3437ed24257895ae1edd9e503cfb352e635a8" && \
  pip3 install --no-cache-dir "git+https://github.com/dremio-hub/arrow-flight-client-examples.git#egg=dremio-flight&subdirectory=python/dremio-flight" && \
  pip3 install --no-cache-dir "git+https://github.com/mage-ai/singer-python.git#egg=singer-python" && \
  pip3 install --no-cache-dir "git+https://github.com/mage-ai/google-ads-python.git#egg=google-ads" && \
  pip3 install --no-cache-dir "git+https://github.com/mage-ai/dbt-mysql.git#egg=dbt-mysql" && \
  pip3 install --no-cache-dir "git+https://github.com/mage-ai/dbt-synapse.git#egg=dbt-synapse" && \
  pip3 install --no-cache-dir "git+https://github.com/mage-ai/mage-ai.git#egg=mage-integrations&subdirectory=mage_integrations"

ENV PYTHONPATH="${PYTHONPATH}:/home/mage_code"
ENV REQUIRE_USER_AUTHENTICATION=1
ENV MAGE_ACCESS_TOKEN_EXPIRY_TIME=1440

CMD ["/bin/sh", "-c", "/app/run_app.sh"]
