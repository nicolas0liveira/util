#!/bin/bash
### ====================================================================== ###
##                                                                      	##
##  Cria, caso não exista, arquivos .gitignore em diretorios vazios  		##
##                                                                          ##
##																			##
## Modificacoes:					 										##
##		+	20150420: Nicolas Oliveira  			 	##
##			- versão inicial												##
##																			##
### ====================================================================== ###

ROOT_DIR_DEFAULT=$(pwd)

echo "Entre com o diretório raiz [default: $ROOT_DIR_DEFAULT]"
read ROOT_DIR;

if [ -z "$ROOT_DIR" ]; then
	ROOT_DIR=$ROOT_DIR_DEFAULT
fi

if [ ! -d "$ROOT_DIR" ]; then
	echo  "Diretorio $ROOT_DIR nao encontrado!	Saindo..."
	sleep 3
	exit 1
fi

EMPTY_DIRS=(${EMPTY_DIRS[@]}`find $ROOT_DIR -type d -empty`)
QTD_EMPTY_DIR=${#EMPTY_DIRS[@]}
if [ $QTD_EMPTY_DIR -eq "0" ]; then
	echo "Nao foram encontrados diretórios vazios"
	sleep 3
	exit 1
fi

echo "Criando arquivos temporarios..."
TMP_DIR="$ROOT_DIR_DEFAULT/.TMPX_$(date '+%H%M%S')"
mkdir $TMP_DIR
if [ $? -ne "0" ]; then
	echo "Erro ao criar diretório temporario: $TMP_DIR"
	sleep 3
	exit 1
fi
#echo "Diretorio temporario criado: $TMP_DIR"

#echo "Criando .gitignore padrão..."
echo "# ignorar temporarios" > $TMP_DIR/.gitignore
echo "*~" >> $TMP_DIR/.gitignore
echo "# ignorar todos" >> $TMP_DIR/.gitignore
echo "#*" >> $TMP_DIR/.gitignore
echo "# exceto o .gitignore" >> $TMP_DIR/.gitignore
echo "#!.gitignore" >> $TMP_DIR/.gitignore

#echo "Criando script para rollback..."
SCRIPT_ROLLBACK="$ROOT_DIR/.generated-script-remove-gitignore_$(date '+%y%m%d%H%M%S').sh"
echo "#!/bin/bash" > $SCRIPT_ROLLBACK
echo "# Executar esse script para remover os arquivos .gitignore criados " >> $SCRIPT_ROLLBACK

i=0;
echo "Copiando arquivos .gitignore..."
while [ $i -lt $QTD_EMPTY_DIR ]; do 
	DIR_2_CREATE=${EMPTY_DIRS[i]}

	##cria arquivos .gitignore
	chmod +x $SCRIPT_ROLLBACK
	if [ ! -e "$DIR_2_CREATE/.gitignore" ]; then
		cp -v $TMP_DIR/.gitignore "$DIR_2_CREATE/.gitignore"
		echo "rm -v $DIR_2_CREATE/.gitignore;" >> $SCRIPT_ROLLBACK
	fi

	i=$(expr 1 + $i)
done


echo "Removendo arquivos temporarios..."
rm -R $TMP_DIR

QTD_EMPTY_DIR=$(find $ROOT_DIR -type d -empty | wc -l)
if [ $QTD_EMPTY_DIR -eq "0" ]; then
	echo "Blz, nao ha mais diretorios vazios =)"
fi

echo "Done!"
