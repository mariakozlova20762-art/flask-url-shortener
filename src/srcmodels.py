from datetime import datetime
from database import db

class ShortLink(db.Model):
    """Модель для хранения коротких ссылок"""
    __tablename__ = 'short_links'
    
    id = db.Column(db.Integer, primary_key=True)
    original_url = db.Column(db.String(2000), nullable=False)
    short_code = db.Column(db.String(20), unique=True, nullable=False, index=True)
    created_at = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    click_count = db.Column(db.Integer, default=0)
    last_clicked_at = db.Column(db.DateTime, nullable=True)
    
    # Связь со статистикой
    click_stats = db.relationship('ClickStat', backref='short_link', 
                                  lazy=True, cascade='all, delete-orphan')
    
    def to_dict(self):
        return {
            'id': self.id,
            'original_url': self.original_url,
            'short_code': self.short_code,
            'created_at': self.created_at.isoformat(),
            'click_count': self.click_count,
            'last_clicked_at': self.last_clicked_at.isoformat() if self.last_clicked_at else None
        }

class ClickStat(db.Model):
    """Модель для хранения статистики кликов"""
    __tablename__ = 'click_stats'
    
    id = db.Column(db.Integer, primary_key=True)
    short_link_id = db.Column(db.Integer, db.ForeignKey('short_links.id'), nullable=False)
    clicked_at = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    ip_address = db.Column(db.String(45), nullable=True)  # IPv6 может быть до 45 символов
    user_agent = db.Column(db.Text, nullable=True)
    browser = db.Column(db.String(100), nullable=True)
    os = db.Column(db.String(100), nullable=True)
    device = db.Column(db.String(100), nullable=True)
    referrer = db.Column(db.String(500), nullable=True)
    
    def to_dict(self):
        return {
            'id': self.id,
            'short_link_id': self.short_link_id,
            'clicked_at': self.clicked_at.isoformat(),
            'ip_address': self.ip_address,
            'browser': self.browser,
            'os': self.os,
            'device': self.device,
            'referrer': self.referrer
        }