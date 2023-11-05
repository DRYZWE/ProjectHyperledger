# Verifica se o sistema é baseado no sistema de gerenciamento de pacotes APT (Debian/Ubuntu)
if command -v apt-get &>/dev/null; then
    # Atualiza a lista de pacotes
    sudo apt update

    # Instala ferramentas de compilação, como build-essential
    sudo apt -y install build-essential

    echo "Artefatos de Compilação instalados com sucesso."

# Adicione verificações para outros sistemas de gerenciamento de pacotes, se necessário.
else
    echo "Sistema não suportado ou não foi possível encontrar apt-get."
    exit 1
fi

# Define a versão do Go a ser instalada
GO_VERSION="1.15.12"

# Verifica se o Go já está instalado
if command -v go &>/dev/null; then
    echo "GoLang já está instalado."
    exit 0
fi

echo "Instalando GoLang..."

# URL de download do Go
GO_DOWNLOAD_URL="https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz"

# Diretório de instalação
INSTALL_DIR="/opt"

# Diretório de destino
TARGET_DIR="$HOME/go"

# Baixa o arquivo tar.gz do Go
curl -fsSL "$GO_DOWNLOAD_URL" -o "/tmp/go.tar.gz"

# Descompacta o arquivo no diretório de instalação
sudo tar -C "$INSTALL_DIR" -xzf /tmp/go.tar.gz

# Remove o arquivo temporário
rm /tmp/go.tar.gz

# Cria o diretório de destino, se ele não existir
mkdir -p "$TARGET_DIR"

# Define as variáveis de ambiente para o Go
echo 'export PATH=$PATH:/opt/go/bin' >> "$HOME/.profile"
echo 'export GOPATH=$HOME/go' >> "$HOME/.profile"

# Carrega as novas variáveis de ambiente
source "$HOME/.profile"

echo "GoLang ${GO_VERSION} instalado com sucesso!"

echo "Instalando Node.js..."

# Adicione o repositório do Node.js e a chave GPG
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] https://deb.nodesource.com/node_14.x $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Atualize o cache do apt
sudo apt update

# Instale o Node.js e o npm
sudo apt install -y nodejs

# Exiba a versão do Node.js e do npm instalados
echo "Node.js $(node -v)"
echo "npm $(npm -v)"

echo "Node.js instalado com sucesso!"

p# Verifica se o Docker já está instalado
if command -v docker &>/dev/null; then
    echo "Docker já está instalado."
else
    echo "Instalando Docker..."
    # Baixa o script de instalação do Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    # Executa o script de instalação do Docker
    sudo sh get-docker.sh
    # Remove o arquivo temporário do script
    rm get-docker.sh
    # Adiciona o usuário atual ao grupo "docker"
    sudo usermod -aG docker $(whoami)
    # Reinicia o serviço Docker
    sudo systemctl restart docker.service
fi

# Verifica se o Docker Compose já está instalado
if command -v docker-compose &>/dev/null; then
    echo "Docker-Compose já está instalado."
else
    echo "Instalando Docker-Compose..."
    # Baixa o Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # Torna o Docker Compose executável
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Limpa arquivos temporários
rm -f go1.15.12.linux-amd64.tar.gz nodesource_setup.sh

# Personaliza variáveis de ambiente (GOPATH e GOROOT)
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export GOROOT=/opt/go" >> ~/.bashrc

# Recarrega as variáveis de ambiente
source ~/.bashrc

echo "Ambiente configurado."

# Reinicia a sessão para garantir que as alterações nas permissões tenham efeito
exec bash