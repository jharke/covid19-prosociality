from ._builtin import Page, WaitPage
from otree.api import Currency as c, currency_range
from .models import Constants

class PaymentInfo(Page):
    form_model = 'player'
    form_fields = ['survey_comments']

    def vars_for_template(self):
        global_donation = self.participant.vars['global_donation']
        local_donation = (self.participant.vars['donation'] -
                          self.participant.vars['global_donation'])
        participation_fee = self.session.config['participation_fee']
        payoff = self.participant.payoff
        if payoff == self.session.config['endowment']:
            non_donor = True
            local_donation = str(100 - int(global_donation)) + '%'
            global_donation = str(int(global_donation)) + '%'
        else:
            non_donor = False
        if self.participant.vars['timeout']:
            payoff = c(0)
        return dict(
            participation_fee=participation_fee,
            payoff=payoff,
            global_donation=global_donation,
            local_donation=local_donation,
            non_donor=non_donor,
        )


class RedirectProlific(Page):
    pass


page_sequence = [PaymentInfo,
                 RedirectProlific]
