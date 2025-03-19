#!/bin/bash

# Preguntar la ubicación de la carpeta
read -p "Introduce el nombre de la carpeta donde deseas inicializar el repositorio Git: " carpeta

# Validar si la carpeta existe
if [ -d "$carpeta" ]; then
    # Cambiar a la carpeta indicada
    cd "$carpeta" || exit
    echo "Ubicación cambiada a: $carpeta"

    # Inicializar el repositorio Git
    git init
    echo "¡Repositorio Git inicializado!"

    # Primer commit
    read -p "Escribe el mensaje para el primer commit: " mensaje1
    git commit --allow-empty -m "$mensaje1"  # --allow-empty para evitar errores si no hay cambios

    # Renombrar la rama principal
    read -p "Introduce el nombre de la rama principal (por defecto 'main'): " nombre_rama
    nombre_rama=${nombre_rama:-main}  # Usa 'main' si no se introduce un nombre
    git branch -M "$nombre_rama"

    # Configurar el repositorio remoto
    read -p "Introduce la URL del repositorio remoto: " url_remota
    git remote add origin "$url_remota"

    # Agregar cambios al área de preparación
    git add .
    echo "Archivos añadidos al área de preparación."

    # Segundo commit
    read -p "Escribe el mensaje para el segundo commit: " mensaje2
    git commit -m "$mensaje2"

    # Hacer push al repositorio remoto
    git push -u origin "$nombre_rama"
    echo "¡Cambios subidos a $url_remota en la rama $nombre_rama!"

    # Pausa final
    read -n 1 -s -r -p "Presiona cualquier tecla para continuar..."
else
    echo "Error: La carpeta '$carpeta' no existe. Por favor, verifica la ruta."
fi
