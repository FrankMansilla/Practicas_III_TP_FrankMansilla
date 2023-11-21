# Practicas Profesionalizantes III - Frank Mansilla

Este proyecto contiene una aplicacion sencilla de python con flask 

## Levantar el Proyecto con Python

1. **Crear y Activar Entorno Virtual:**
   - Ejecuta el siguiente comando para crear un entorno virtual:
     ```
     python -m venv venv
     ```

   - Activa el entorno virtual:
     - En Windows:
       ```
       .\venv\Scripts\activate
       ```
     - En Linux/Mac:
       ```
       source venv/bin/activate
       ```

2. **Ejecutar el Proyecto con Python:**
   - Ejecuta el siguiente comando para iniciar el proyecto:
     ```
     python <app.py>
     ```

## Levantar el Proyecto con Docker

- Ejecuta el siguiente comando para iniciar el proyecto con Docker:
    ```
    docker-compose up
    ```



## GitHub Actions

### Verificación del Estado del Proyecto

- El primer workflow de GitHub Actions verifica el estado del proyecto. Este flujo de trabajo está basado en la documentación oficial de GitHub.

### Confirmación del Programa en el Puerto 3359

- El segundo workflow de GitHub Actions se encarga de confirmar que el programa se levanta correctamente en el puerto 3359.

## Hooks

### Pre-commit

- El hook pre-commit verifica que el archivo "requeriments.txt" no tenga más de 12 líneas de código antes de realizar el commit. Si excede este límite, el commit se cancela.

### Post-commit

- Mientras estás en la rama `Develop` al realizar un commit, el hook post-commit realiza automáticamente un push a la rama `origin/develop`.

---

## Amazon Web Service (AWS)

### Paso 1: Crear Instancia EC2 Individual
 ```
aws ec2 run-instances \
    --image-id ami-xxxxxxxxxxxxx \  
    --instance-type t2.micro \       
    --key-name my-key-pair \         
    --security-groups MySecurityGroup \ 
    --user-data '#!/bin/bash
                 sudo apt update
                 sudo apt install -y python3 python3-pip
                 sudo pip3 install -r /path/to/requirements.txt'
 ```
- Descripción:
   Crea una instancia EC2 con la imagen especificada (ami-xxxxxxxxxxxxx).
   Utiliza una instancia de tipo t2.micro.
   Asigna la clave my-key-pair para acceder a la instancia.
   Asocia la instancia con el grupo de seguridad `MySecurityGroup`.
   Ejecuta un script de inicio de usuario (user-data) que actualiza el sistema, instala Python 3 y pip, y luego instala las dependencias desde el archivo `requirements.txt`.

  ### Paso 2: Configurar Auto Scaling

  ```
  aws autoscaling create-launch-configuration \
    --launch-configuration-name MyLaunchConfig \
    --image-id ami-xxxxxxxxxxxxx \
    --instance-type t2.micro \
    --key-name my-key-pair \
    --security-groups MySecurityGroup \
    --user-data '#!/bin/bash
                 sudo apt update
                 sudo apt install -y python3 python3-pip
                 sudo pip3 install -r /path/to/requirements.txt'
   ```
- Descripción:
   Crea una configuración de lanzamiento para las instancias de Auto Scaling.
   Especifica la misma configuración que la instancia individual, incluyendo la instalación de Python y las dependencias desde `requirements.txt`.

  ### Paso 3: Crear Grupo De Auto Scaling
  ```
   aws autoscaling create-auto-scaling-group \
       --auto-scaling-group-name MyAutoScalingGroup \
       --launch-configuration-name MyLaunchConfig \
       --min-size 1 \
       --max-size 3 \
       --desired-capacity 2 \
       --availability-zones us-east-1a us-east-1b \
       --vpc-zone-identifier subnet-xxxxxxxxxxxxx \
       --tags Key=Name,Value=MyAutoScalingGroup,PropagateAtLaunch=true

    ```

- Descripción:
   Crea un grupo de Auto Scaling llamado `MyAutoScalingGroup`.
   Asocia la configuración de lanzamiento `MyLaunchConfig`.
   Establece la capacidad mínima, máxima y deseada.
   Especifica las zonas de disponibilidad y la subred.



  ### Paso 4: Configurar Políticas de Escalado

- Política de Escalado hacia Arriba:
  
    ```
  aws autoscaling put-scaling-policy \
    --auto-scaling-group-name MyAutoScalingGroup \
    --policy-name ScaleUpPolicy \
    --scaling-adjustment 1 \
    --adjustment-type ChangeInCapacity \
    --cooldown 300 \
    --metric-name CPUUtilization \
    --namespace AWS/EC2 \
    --statistic Average \
    --comparison-operator GreaterThanOrEqualToThreshold \
    --threshold 70 \
    --evaluation-periods 2

    ```

    - Descripción:
      Configura una política de escalado que incrementa la capacidad si la utilización de CPU es mayor al 70%.

- Política de Escalado hacia Abajo:
```
aws autoscaling put-scaling-policy \
    --auto-scaling-group-name MyAutoScalingGroup \
    --policy-name ScaleDownPolicy \
    --scaling-adjustment -1 \
    --adjustment-type ChangeInCapacity \
    --cooldown 300 \
    --metric-name CPUUtilization \
    --namespace AWS/EC2 \
    --statistic Average \
    --comparison-operator LessThanOrEqualToThreshold \
    --threshold 30 \
    --evaluation-periods 2
```
- Descripción:
Configura una política de escalado que reduce la capacidad si la utilización de CPU es menor al 30%.

### Paso 5: Autorizar Tráfico al Grupo de Seguridad
```
aws ec2 authorize-security-group-ingress \
    --group-name MySecurityGroup \
    --protocol tcp \
    --port 22 \
    --source 0.0.0.0/0 \
    --region us-east-1
```

- Descripción:
Autoriza el tráfico entrante al grupo de seguridad MySecurityGroup en el puerto 22 desde cualquier origen (0.0.0.0/0).

