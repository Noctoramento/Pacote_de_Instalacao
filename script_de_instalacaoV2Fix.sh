#!/bin/bash

#Função com a assinatura noctoramento
ass_noctoramento() {
	echo "$(tput setaf 5)
	 	╭━╮╱╭╮╱╱╱╱╱╱╱╱╱╭╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮╱╱╱╱╱$'\n'
        ┃┃╰╮┃┃╱╱╱╱╱╱╱╱╭╯╰╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╯╰╮╱╱╱╱$'\n'
        ┃╭╮╰╯┃╭━━╮╭━━╮╰╮╭╯╭━━╮╭━╮╭━━╮╭╮╭╮╭━━╮╭━━╮╰╮╭╯╭━━╮$'\n'
        ┃┃╰╮┃┃┃╭╮┃┃╭━╯╱┃┃╱┃╭╮┃┃╭╯┃╭╮┃┃╰╯┃┃┃━┫┃╭╮┃╱┃┃╱┃╭╮┃$'\n'
        ┃┃╱┃┃┃┃╰╯┃┃╰━╮╱┃╰╮┃╰╯┃┃┃╱┃╭╮┃┃┃┃┃┃┃━┫┃┃┃┃╱┃╰╮┃╰╯┃$'\n'
        ╰╯╱╰━╯╰━━╯╰━━╯╱╰━╯╰━━╯╰╯╱╰╯╰╯╰┻┻╯╰━━╯╰╯╰╯╱╰━╯╰━━╯$'\n'
        ╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱$'\n'
        ╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱."
}

# Função para verificar se o Java está instalado
check_java() {
    if type -p java > /dev/null 2>&1; then
        echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Java está instalado."
        return 0
    else
        echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Java não está instalado. Vamos instalá-lo."
        return 1
    fi
}

# Função para verificar se o docker está instalado
check_docker(){
    if type -p docker > /dev/null 2>&1; then
        echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Docker está instalado."
        return 0
    else
        echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Docker não está instalado, vamos instalá-lo"
        return 1
    fi
}

# Função para preparar o ambiente
prep_ambiente() {
	echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Olá, serei seu ajudande durante essa instalação..."
	echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Primeiro irei atualizar seus pacotes..."
	sudo apt update -y  &> /dev/null
    sudo apt upgrade -y  &> /dev/null
	if [ $? = 0 ];then
		echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Atualização realizada com sucesso :)"
		return 0
	else
		echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Infelizmente, não consegui atualizar seus pacotes, por favor verifique a conexão e tente novamente"
		return 1
	fi
}

# Função para instalar o Java
install_java() {
    echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Instalando Java, aguarde..."

    sudo apt install openjdk-17-jre -y &> /dev/null &
    progress_bar 15
    wait
    echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Java instalado com sucesso."
}

# Função para instalar o Docker
install_docker() {
    echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Instalando Docker, aguarde..."
    sudo apt install docker.io -y &> /dev/null &
    progress_bar 20
    wait
    echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Docker instalado com sucesso."
}

# Função para configurar o Docker com MySQL
config_docker() {
	echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Um momento agora vou configurar o Docker..."
	sudo systemctl start docker
	sudo systemctl enable docker
	echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Configuração finalizada, criando imagem para o container..."
	sudo docker build -t banco-noctoramento .
	if [ $? = 0 ];then
		sudo docker run -d --name container-noctoramento -p 3306:3306 banco-noctoramento
		echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Container criado com sucesso"
		return 0
	else
		echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Erro ao criar o container, tente novamente mais tarde..."
		return 1
	fi
}

#Função para iniciar o Jar
init_jar() {
	echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Tudo pronto, deseja iniciar a aplicação?"
	read get
	if [ \"$get\" == \"S\" ];then
		echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Instalação concluída, iniciando aplicação, aguarde um instante..."
		sudo ./noctoramento
	else
		echo "$(tput setaf 5)[Noctoramento Helper]:$(tput setaf 7) Instalação concluída, seja bem-vindo a família Noctoramento..."
	fi
}

ass_noctoramento
prep_ambiente
if [ $(check_java) == 0 ];then
	install_java
else
	if [ $(check_docker) == 0 ];then
		install_docker
	else
		if [ $(config_docker) == 0 ];then
		init_jar
		ass_noctoramento
		fi
	fi
fi
