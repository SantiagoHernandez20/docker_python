FROM python
RUN pip install flask
WORKDIR /home/myapp
COPY ./static /home/myapp/static
COPY ./templates /home/myapp/templates
COPY flask_app.py /home/myapp/
EXPOSE 5050
CMD python3 /home/myapp/flask_app.py
