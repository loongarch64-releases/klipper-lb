FROM lcr.loongnix.cn/library/debian:unstable

RUN apt update && apt install -y git \
    make \
    docker-cli

    

ENV KLIPPER_LB_VERSION=''

CMD ["sh", "-c","/workspace/process_version.sh $KLIPPER_LB_VERSION"]
