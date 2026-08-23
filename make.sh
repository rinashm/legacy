#!/bin/bash

# Прошу не модифицировать именно этот скрипт и не удалять его. Он нужен, чтобы
# собирать файл во временной папке, находящейся в оперативной памяти; там же
# генерируются служебные файлы. Благодаря тому, что временная папка находится в
# оперативной памяти, при перекомпиляции не происходит перезаписи файлов на
# SSD. Бережём ресурсы диска
# — Rikudo

outdir="/tmp/legacy"
name=legacy

do_pdflatex() {
	pdflatex \
		--shell-escape \
		--output-directory "$outdir" \
		$name.tex
}

do_biblatex() {
	biber \
		--output-directory "$outdir" \
		$name
}

if [[ ! -a "$outdir" ]]
then
	mkdir -p "$outdir" 
fi

case $1 in
	--all|-a)
		do_pdflatex
		do_biblatex
		do_pdflatex
		;;

	*)
		do_pdflatex
esac
