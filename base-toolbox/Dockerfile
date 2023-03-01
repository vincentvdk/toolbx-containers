FROM fedora:37
LABEL com.github.containers.toolbox="true"

# -- Packages
RUN dnf install -y tmux passwd bash zsh fuse fuse-libs curl git unzip procps-ng ripgrep bat pgp-tools wl-clipboard && dnf clean all

# -- Directories
#RUN mkdir -p /opt/config/zsh
#RUN mkdir -p /opt/config/fzf
RUN bash -c 'mkdir -p /opt/config/{fzf,zsh,tmux}'
RUN mkdir -p /opt/config/zsh/.antigen
RUN mkdir -p /opt/bin

# -- FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/config/fzf && /opt/config/fzf/install --no-zsh

# -- ZSH
RUN curl -L git.io/antigen > /opt/config/zsh/.antigen/antigen.zsh
COPY zshrc /opt/config/zsh/.zshrc
COPY zsh_aliases /opt/config/

# -- TMUX
#RUN mkdir -p /opt/config/tmux
COPY tmux.conf /opt/config/tmux/tmux.conf

# -- ASDF for binaries
RUN git clone https://github.com/asdf-vm/asdf.git /opt/bin/asdf --branch v0.10.2

# -- powerlevel20k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /opt/powerlevel10k
COPY p10k.zsh /opt/config/zsh/p10k.zsh

# -- NodeJS, nvm, npm,..
ENV NVM_DIR="/opt/nvm"
RUN git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR" && \
  cd "$NVM_DIR" && \
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` && . "$NVM_DIR/nvm.sh" && \
  nvm install node && \
  npm install -g typescript typescript-language-server

# -- Charm
RUN dnf install -y https://github.com/charmbracelet/charm/releases/download/v0.12.4/charm_0.12.4_linux_amd64.rpm \
  	https://github.com/charmbracelet/gum/releases/download/v0.6.0/gum_0.6.0_linux_amd64.rpm
COPY scripts/ /opt/bin

# -- basic bash config to set hostname and such (might need to look into a better solution later on)
RUN echo 'export HOSTNAME=`cat /run/.containerenv | grep 'name=' | cut -d= -f2`' >> ~/.bashrc

# add someting like in this GH issue https://github.com/containers/toolbox/issues/145

# -- ENV
ENV ZDOTDIR=/opt/config/zsh
ENV FZF_BASE=/opt/config/fzf
ENV XDG_CONFIG_HOME=/opt/config
ENV ASDF_DIR=/opt/bin/asdf
