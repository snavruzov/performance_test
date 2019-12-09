from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://angelo:rhjrjlbk@localhost:3307/lead_test'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class Lead(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    full_name = db.Column(db.String(120), nullable=True)
    email = db.Column(db.String(120), nullable=True)
    phone = db.Column(db.String(120), nullable=True)

    def __repr__(self):
        return '<Lead %r>' % self.username


@app.route('/')
def select():
    admin = Lead.query.filter_by(full_name='Sardor').first()
    email = admin.email if admin else ''
    return email


@app.route('/add')
def add():
    admin = Lead(full_name='Sardor', email='admin@example.com')
    db.session.add(admin)
    db.session.commit()
    return 'Hello World!'


if __name__ == '__main__':
    app.run()
