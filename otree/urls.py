from django.urls import path
from otree.urls import urlpatterns
import introduction.pages

urlpatterns.append(path('check/', introduction.pages.check_browser))
