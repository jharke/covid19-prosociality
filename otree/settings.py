from os import environ

SESSION_CONFIG_DEFAULTS = dict(
    participation_fee=1.70,
    real_world_currency_per_point=1,
    endowment=1,
    doc=""
)

SESSION_CONFIGS = [dict(
    name='corona_donation_experiment',
    num_demo_participants=60,
    app_sequence=[
        'introduction',
        'corona_donation_experiment',
        'payment_info',
    ],
    use_browser_bots=False
)]

LANGUAGE_CODE = 'en'
REAL_WORLD_CURRENCY_CODE = 'GBP'
USE_POINTS = False

ROOMS = [
    dict(
        name='corona_donation_experiment',
        display_name='Corona Donation Experiment',
    ),
]

ADMIN_USERNAME = 'admin'
ADMIN_PASSWORD = environ.get('OTREE_ADMIN_PASSWORD', default='otree_unsecure')
SECRET_KEY = environ.get('OTREE_SECRET_KEY', default='otree_unsecure')
DEBUG = environ.get('OTREE_PRODUCTION', default=False)
INSTALLED_APPS = ['otree']
ROOT_URLCONF = 'urls'
