from ._builtin import Page, WaitPage
from otree.api import Currency as c, currency_range
from .models import Constants
import json


def get_progress(x, pages):
    try:
        progress = 100*(
            (x.participant._index_in_pages - 1)/len(pages)
        )
    except Exception as e:
        print(e)
        progress = 0
    return progress


class PageProgress(Page):
    def vars_for_template(self):
        return dict(
            page_number=get_progress(self, page_sequence),
        )


class Donation(PageProgress):
    form_model = 'player'
    form_fields = [
        'donation',
        'initial_donation',
    ]

    def before_next_page(self):
        self.player.set_payoff()
        self.participant.vars['donation'] = self.player.donation


class DonationAllocation(Page):
    form_model = 'player'
    form_fields = [
        'global_share',
        'initial_global_share',
        'global_donation',
    ]

    def vars_for_template(self):
        if self.player.donation == 0:
            donation = 1
        else:
            donation = self.player.donation
        return dict(
            total_donation=f'{donation:.2f}',
            page_number=get_progress(self, page_sequence),
        )

    def js_vars(self):
        if self.player.donation == 0:
            donation = 100
        else:
            donation = self.player.donation
        return dict(
            donation=donation,
        )

    def before_next_page(self):
        self.participant.vars['global_donation'] = self.player.global_donation


class SurveyInfo(PageProgress):
    pass


class Demographics(PageProgress):
    form_model = 'player'
    form_fields = [
        'qHouseholdAdults',
        'qHouseholdChildren',
        'qUrban',
        'qStatus',
        ]


class Location(PageProgress):
    form_model = 'player'
    form_fields = [
        'qLocationInput',
        'qLocation',
        'qZip',
    ]

    def error_message(self, values):
        if values['qLocation'] is None and values['qZip'] is None:
            return (
                'After typing you still need to select your '
                'area from the list below the input field. '
                'Please try again and click on the name of your area.'
            )


class Covid(PageProgress):
    form_model = 'player'
    form_fields = [
        'qCasesUtlaEstimated',
        'qCasesUtlaMoreSevere',
        'qCasesUkEstimated',
        'qCasesUkMoreSevere',
    ]

    def js_vars(self):
        if self.player.qZip:
            area = None
        else:
            area = self.player.qLocation
        return dict(
            area=area,
        )


class Health(PageProgress):
    form_model = 'player'
    form_fields = [
        'qHealth',
        'qHealthFuture',
        'qHealthRisk',
    ]


class Behaviour(PageProgress):
    form_model = 'player'
    form_fields = [
        'qContactsReduced',
        'qBasicStock',
        'qMask',
        'qLeaveHome1',
        'qLeaveHome2',
        'qLeaveHome3',
        'qLeaveHome4',
        'qLeaveHome5',
        'qLeaveHome6',
        'qLeaveHome7',
        'qLeaveHome8',
        'qLeaveHome9',
        'qLeaveHome10',
        'qLeaveHome11',
        'qLeaveHome12',
        'qFollowRules',
        'qCovidContribution',
        'qCovidContributionHow',
    ]


class Work(PageProgress):
    form_model = 'player'
    form_fields = [
        'qWorkFulltime',
        'qWorkChange',
        'qWorkChangeText',
        'qCommuteBefore',
        'qCommuteModeBefore',
        'qCommuteTimeBefore',
        'qCommuteAfter',
        'qCommuteModeAfter',
        'qCommuteTimeAfter',
        'qDistanceWork',
        'qRemoteWork',
    ]

    def error_message(self, values):
        if values['qWorkChange'] is None and values['qWorkChangeText'] is None:
            return (
                'Please share your experiences regarding '
                'your work situation since the outbreak of '
                'the COVID-19 pandemic by either choosing one '
                'of the options in the list or by describing '
                'your experiences in the gray box below.'
            )



class Financial(PageProgress):
    form_model = 'player'
    form_fields = [
        'qIncome',
        'qIncomeChange',
        'qIncomeFuture',
        'qMemBefore',
        'qMemFuture',
    ]


class UkWorld(PageProgress):
    form_model = 'player'
    form_fields = [
        'qGdpUk',
        'qGdpDeveloping',
        'qPoveryUk',
        'qPoveryDeveloping',
    ]


class News(PageProgress):
    form_model = 'player'
    form_fields = [
        'qNews',
    ]


class Risk(PageProgress):
    form_model = 'player'
    form_fields = [
        'qCovidRisk',
        'qLockdown',
        'qPolicies',
        'qCovidManmade',
        'qCovidOnPurpose',
        'qCovidOvercome',
        'qVaccine',
        'qVaccinate',
    ]


class Empathy(PageProgress):
    form_model = 'player'
    form_fields = [
        'qEmpathy1',
        'qEmpathy2',
        'qEmpathy3',
        'qEmpathy4',
        'qEmpathy5',
        'qEmpathy6',
        'qEmpathy7',
    ]


page_sequence = [
    Donation,
    DonationAllocation,
    SurveyInfo,
    Demographics,
    Location,
    Covid,
    Health,
    Behaviour,
    Work,
    Financial,
    UkWorld,
    News,
    Risk,
    Empathy,
]
