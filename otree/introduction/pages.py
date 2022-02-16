from ._builtin import Page, WaitPage
from otree.api import Currency as c, currency_range
from .models import Constants
import time
from django.http import HttpResponse
from django.shortcuts import redirect
from ua_parser import user_agent_parser


def check_browser(request):
    header = request.headers['user-agent']
    try:
        user_agent = user_agent_parser.ParseUserAgent(header)
        with open('user_agents.log', 'a') as fp:
            fp.write(str(user_agent) + '\n')
    except Exception as e:
        print(e)
    if 'MSIE' in header or 'Trident' in header:
        return HttpResponse((
            'You are using the Internet Explorer.<br><br>'
            'As we mentioned in the study description '
            'you need to use a modern browser to participate '
            'in this study. Please use Microsoft Edge, '
            'Google Chrome, Mozilla Firefox, or any other modern browser.'
        ))
    else:
        if request.GET.get('id'):
            response = redirect(
                '/room/corona_donation_experiment/?participant_label=' +
                request.GET.get('id')
            )
            return response
        else:
            return HttpResponse((
                'Your Prolific ID was not passed correctly.<br><br>'
                'Please use the link provided by Prolific.'
            ))


class Introduction(Page):
    def before_next_page(self):
        self.participant.vars['expiry'] = time.time() + 1*60
        self.participant.vars['timeout'] = False

    def vars_for_template(self):
        return dict(
            page_number=1,
        )


page_sequence = [
    Introduction,
]
