
ARG DOCKER_OWNER
ARG DOCKER_PREFIX
ARG ROS_DISTRO
ARG ROOT_CONTAINER=${DOCKER_OWNER}/${DOCKER_PREFIX}-${ROS_DISTRO}
FROM $ROOT_CONTAINER

ARG USERNAME
ARG USER_UID
ARG USER_GID

# Delete user if it exists in container (e.g Ubuntu Noble: ubuntu)
RUN if id -u $USER_UID ; then userdel `id -un $USER_UID` ; fi

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN mkdir /home/$USERNAME/projects \
    && chown -R  $USERNAME:$USERNAME /home/$USERNAME/projects 
RUN apt-get update && apt-get upgrade -y
ENV SHELL /bin/bash

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
# enable some tmux features
RUN echo 'set -g mouse on' >> ~/.tmux.conf
RUN echo 'bind-key k kill-session' >> ~/.tmux.conf
RUN echo 'set-option -g history-limit 100000' >> ~/.tmux.conf
RUN echo 'set -g pane-border-format "#{pane_index} #{pane_title}"' >> ~/.tmux.conf
RUN echo 'set -g pane-border-status bottom' >> ~/.tmux.conf
# defines your projects base
RUN echo 'export PROJECTS_DIR=${HOME}/projects' >> ~/.bashrc 
# forces your bash to source env.sh if it exists
RUN echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc 
# change bash colour in container
RUN sed -i 's|\\\[\\033\[01;32m\\\]\\u@\\h|\\\[\\033\[01;43m\\\]\\u@\\h|g' ~/.bashrc 
CMD ["/bin/bash"]
