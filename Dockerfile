FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /home/ubuntu/tcc/

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['*'\]/" setup/settings.py

RUN python manage.py migrate

RUN python manage.py loaddata clientes.json

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]

EXPOSE 8000
