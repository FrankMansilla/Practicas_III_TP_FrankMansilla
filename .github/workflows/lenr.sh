#!/bin/bash

# Verificar si el archivo requirements.txt existe en el directorio anterior
if [ -f "../requirements.txt" ]; then
    lines=$(wc -l < "../requirements.txt")
    if [ "$lines" -gt 12 ]; then
        echo "Error: El archivo requirements.txt tiene más de 12 líneas."
        exit 1
    fi
else
    echo "Error: No se encontró el archivo requirements.txt en el directorio anterior."
    exit 1
fi

echo "El archivo requirements.txt tiene 12 o menos líneas de código."
