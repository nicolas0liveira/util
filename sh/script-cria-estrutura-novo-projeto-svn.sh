#!/bin/bash

# Criado em: não lembro
# Last Change: não lembro
# Instituicao: nenhuma
# Proposito do script: criar uma estrutura básica de projeto no svn.
# Autor: Nícolas Oliveira
# site: nenhum

URL_SVN="http://127.0.0.1:18080/svn/projetos_web"

echo "Montando estrutura de diretórios para novo projeto do SVN ($URL_SVN) ..."

echo "Nome do projeto:"
read NOME_DO_PROJETO

while [  "$NOME_DO_PROJETO" == ""  ]
do
	echo 'O nome do projeto não pode ser vazio!'
	echo "Nome do projeto:"
	read NOME_DO_PROJETO
done



echo "Criando estrutura local..."
mkdir -v $NOME_DO_PROJETO
cd $NOME_DO_PROJETO
mkdir -v -p braches/colaboradores
mkdir -v -p braches/versoes
mkdir -v -p tags/entregas/homologacao
mkdir -v -p tags/entregas/producao
mkdir -v -p trunk/01_Documentacao/01_Formalizacoes
mkdir -v -p trunk/01_Documentacao/02_Requisitos
mkdir -v -p trunk/01_Documentacao/03_Especificacoes
mkdir -v -p trunk/01_Documentacao/04_Manuais
mkdir -v -p trunk/01_Documentacao/05_Testes
mkdir -v -p trunk/01_Documentacao/99_Referencias
mkdir -v -p trunk/02_Implementacao


echo "Importando estrutura (projeto) para o SVN..."
svn import . "$URL_SVN/$NOME_DO_PROJETO" --message 'Criação da estrutura inicial do projeto'

echo "Removendo estrutura local criada..."
cd ..
rm -R $NOME_DO_PROJETO


echo "Fim"