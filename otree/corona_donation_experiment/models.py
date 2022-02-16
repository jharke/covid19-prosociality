from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
import itertools
from widgets.SliderExt import SliderExt


class Constants(BaseConstants):
    name_in_url = 'corona_donation_experiment'
    players_per_group = None
    num_rounds = 1


class Subsession(BaseSubsession):
    def creating_session(self):
        treatment_balanced = itertools.cycle([0, 1])
        for player in self.get_players():
            player.treatment_covid = next(treatment_balanced)


class Group(BaseGroup):
    pass


class Player(BasePlayer):

    treatment_covid = models.IntegerField()

    donation = models.CurrencyField()

    initial_donation = models.FloatField(
        widget=widgets.HiddenInput()
    )

    global_share = models.FloatField()

    global_donation = models.CurrencyField(
        widget=widgets.HiddenInput()
    )

    initial_global_share = models.FloatField(
        widget=widgets.HiddenInput()
    )

    def set_payoff(self):
        self.payoff = c(self.session.config['endowment']) - self.donation

    qHouseholdAdults = models.IntegerField(
        label='''How many adults, including yourself, live in your household?''',
        min=1,
        max=99,
        blank=False)

    qHouseholdChildren = models.IntegerField(
        label='''How many children live in your household?''',
        min=0,
        max=99,
        blank=False)

    qUrban = models.StringField(
        label='''Where do you live?''',
        choices=[
            'In a city with over 100,000 inhabitants',
            'In a city with up to 100,000 inhabitants',
            'In the commuter belt around a city',
            'In a rural area',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qStatus = models.StringField(
        label='''What is your primary employment status?''',
        choices=[
            'Employed or self-employed',
            'Unemployed but actively looking for work',
            'Student',
            'Apprentice',
            'Retired',
            'Not in the workforce',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qLocationInput = models.StringField(
        label='',
        blank=True,
    )

    qLocation = models.StringField(
        widget=widgets.HiddenInput(),
        blank=True,
    )

    qZip = models.StringField(
        label='''You can also manually enter your postcode, county, or district
        here:''',
        blank=True
    )

    qCasesUtlaEstimated = models.IntegerField(
        label='''How many confirmed COVID-19 cases are there in
        <span class="zip">your area</span> to date?
        Please enter your guess:''',
        min=0,
        max=999999999,
        blank=False)

    qCasesUtlaMoreSevere = models.StringField(
        label='''In your opinion, is the COVID-19 pandemic more or less severe in
        <span class="zip">your area</span> than in other areas in
        England?''',
        choices=[
            'More severe',
            'Equally severe',
            'Less severe',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qCasesUkEstimated = models.IntegerField(
        label='''How many confirmed COVID-19 cases are there in the UK to date?
        Please enter your guess:''',
        min=0,
        max=999999999,
        blank=False)

    qCasesUkMoreSevere = models.StringField(
        label='''In your opinion, is the COVID-19 pandemic more or less severe in the
        UK than in developing countries?''',
        choices=[
            'More severe',
            'Equally severe',
            'Less severe',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    # HEALTH

    qHealth = models.StringField(
        label='''Has your health or the health of your family members been
        negatively affected by the COVID-19 pandemic?''',
        choices=[
            'A lot',
            'Somewhat',
            'Not at all',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qHealthFuture = models.StringField(
        label='''In the next 12 months, do you expect that your health or the health
        of your family members will be negatively affected by the
        Corona virus?''',
        choices=[
            'A lot',
            'Somewhat',
            'Not at all',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qHealthRisk = models.StringField(
        label='''Some people are at risk of becoming seriously ill if infected by
        COVID-19. What risk category do you belong to?''',
        choices=[
            'High risk (clinically extremely vulnerable)*',
            'Moderate risk (clinically vulnerable)**',
            'Neither of the above',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    # BEHAVIOUR

    qContactsReduced = models.StringField(
        label='''I have reduced the number of contacts with people outside my
        household''',
        choices=[
            'A lot',
            'Somewhat',
            'Not at all',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qBasicStock = models.StringField(
        label='''I have increased my stock of basic necessities, medication, or
        sanitary products''',
        choices=[
            'A lot',
            'Somewhat',
            'Not at all',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qMask = models.StringField(
        label='''I wear a mask when I leave the house''',
        choices=[
            'Always',
            'Sometimes',
            'Never',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    # In HTML label='''For which of the following activities did you
    # leave your house in the last 4 weeks (multiple answers
    # possible)?'''
    qLeaveHome1 = models.BooleanField(
        label='''Work''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome2 = models.BooleanField(
        label='''Religious services''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome3 = models.BooleanField(
        label='''Restaurant or café''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome4 = models.BooleanField(
        label='''Basic grocery shopping''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome5 = models.BooleanField(
        label='''Other shopping''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome6 = models.BooleanField(
        label='''Walk a dog''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome7 = models.BooleanField(
        label='''Physical activity or leisure outdoors alone or with members of own
        household''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome8 = models.BooleanField(
        label='''Physical activity or leisure outdoors with members of other
        households''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome9 = models.BooleanField(
        label='''Doctor or pharmacy''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome10 = models.BooleanField(
        label='''Meet friends or relatives''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome11 = models.BooleanField(
        label='''Help neighbours or family in need''',
        widget=widgets.CheckboxInput,
        blank=True)
    qLeaveHome12 = models.BooleanField(
        label='''Social gatherings or demonstrations''',
        widget=widgets.CheckboxInput,
        blank=True)

    qFollowRules = models.StringField(
        label='''Do you follow the guidance and advice of the UK government on the
        COVID-19 pandemic?''',
        choices=[
            'Always',
            'Very Often',
            'Sometimes',
            'Rarely',
            'Never',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qCovidContribution = models.StringField(
        label='''To what extent do you agree with the following statement?
        I have done my bit to prevent and tackle COVID-19.''',
        choices=[
            'Agree totally',
            'Agree partly',
            'Neither agree nor disagree',
            'Disagree partly',
            'Disagree totally',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qCovidContributionHow = models.StringField(
        label='''Please specify what have you done to prevent and tackle
        COVID-19''',
        blank=False)

    # WORK

    qWorkFulltime = models.StringField(
        label='''Were you working <b>before</b> the COVID-19 pandemic?''',
        choices=[
            'Yes, full time',
            'Yes, part time',
            'No',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qWorkChange = models.StringField(
        label='''Have you experienced any of the following <b>since</b> the outbreak
        of the COVID-19 pandemic?''',
        choices=[
            'Permanently laid off',
            'Temporarily laid off (with pay)',
            'Temporarily laid off (without pay)',
            'Reduced number of working hours',
            'Increased number of working hours',
            'Start of a new job',
            'None of the above',
        ],
        widget=widgets.RadioSelect,
        blank=True)

    qWorkChangeText = models.StringField(
        label='''Describe shortly your experiences regarding your work situation
        since the outbreak of the COVID-19 pandemic:''',
        blank=True)

    qCommuteBefore = models.IntegerField(
        label='''How many days a week did you commute <b>before</b> the outbreak of
        COVID-19?''',
        choices=[
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
        ],
        blank=False)

    qCommuteModeBefore = models.StringField(
        label='''What mode of transport did you use <b>before</b> the outbreak of
        COVID-19?''',
        choices=[
            'Public transport',
            'Private transport',
        ],
        widget=widgets.RadioSelect(attrs={'class': 'hidden'}),
        blank=True)

    qCommuteTimeBefore = models.StringField(
        label='''How long was your daily commuting time <b>before</b> the outbreak
        of COVID-19?''',
        choices=[
            'Less than 1 hour',
            'Less than 2 hours',
            'More than 2 hours',
        ],
        widget=widgets.RadioSelect(attrs={'class': 'hidden'}),
        blank=True)

    qCommuteAfter = models.IntegerField(
        label='''How many days did you commute <b>last week</b>?''',
        choices=[
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
        ],
        blank=False)

    qCommuteModeAfter = models.StringField(
        label='''What mode of transport did you mainly use <b>last week</b>?''',
        choices=[
            'Public transport',
            'Private transport',
        ],
        widget=widgets.RadioSelect(attrs={'class': 'hidden'}),
        blank=True)

    qCommuteTimeAfter = models.StringField(
        label='''How long was your daily commuting time <b>last week</b>?''',
        choices=[
            'Less than 1 hour',
            'Less than 2 hours',
            'More than 2 hours',
        ],
        widget=widgets.RadioSelect(attrs={'class': 'hidden'}),
        blank=True)

    qDistanceWork = models.StringField(
        label='''In your daily life, is it easy to maintain a distance of at least 2
        meters to people from outside your household?''',
        choices=[
            'Always',
            'Mostly',
            'Rarely',
            'Never',
        ],
        widget=widgets.RadioSelect,
        blank=False)

    qRemoteWork = models.StringField(
        label='''Do you work remotely or do you have this option?''',
        choices=[
            'Yes, I work (or can work) fully remotely',
            'Yes, but this option is only sometimes available',
            'No, I do not have the option of remote working',
            'Not applicable',
        ],
        widget=widgets.RadioSelect(),
        blank=True)

    # FINANCIAL

    qIncome = models.StringField(
        label='''Your total monthly household income from all sources before tax
        was:''',
        choices=[
            'Up to £2000',
            'More than £2000 up to £5000',
            'More than £5000 up to £10000',
            'More than £10000',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qMemBefore = models.StringField(
        label='''Your household was able to make ends meet:''',
        choices=[
            'With great difficulty',
            'With some difficulty',
            'Fairly easily',
            'Easily',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qIncomeChange = models.StringField(
        label='''Relative to the time <b>before</b> the COVID-19 pandemic, your
        household income has:''',
        choices=[
            'Decreased a lot',
            'Decreased somewhat',
            'Stayed the same',
            'Increased somewhat',
            'Increased a lot',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qMemFuture = models.StringField(
        label='''Your household is able to make ends meet:''',
        choices=[
            'With great difficulty',
            'With some difficulty',
            'Fairly easily',
            'Easily',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qIncomeFuture = models.StringField(
        label='''Relative to the time <b>before</b> the COVID-19 pandemic, do you
        expect your household income will:''',
        choices=[
            'Decrease a lot',
            'Decrease somewhat',
            'Stay the same',
            'Increase somewhat',
            'Increase a lot',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    # UK and the world

    qGdpUk = models.FloatField(
        label='''In 2019, UK GDP grew by 1.4%. What is your estimate of the GDP
        growth in the UK in 2020?''',
        min=-25,
        max=25,
        widget=widgets.Slider(attrs={'step': '0.1', 'class': 'slider-number'})
    )

    qGdpDeveloping = models.FloatField(
        label='''In 2019, IMF found the GDP growth in the developing economies was
        3.7%. What is your estimate of the GDP growth in the
        developing economies in 2020?''',
        min=-25,
        max=25,
        widget=widgets.Slider(attrs={'step': '0.1', 'class': 'slider-number'})
    )

    qPoveryUk = models.FloatField(
        label='''In 2019, 22% of the UK population were living in poverty.* What is
        your estimate for the poverty rate in the UK in 2020?''',
        min=0,
        max=50,
        widget=widgets.Slider(attrs={'step': '1', 'class': 'slider-number'})
    )

    qPoveryDeveloping = models.FloatField(
        label='''In 2019, 23% of people in the developing countries were
        multidimensionally poor.** What is your estimate for the
        multidimentional poverty rate in the developing countries in
        2020?''',
        min=0,
        max=50,
        widget=widgets.Slider(attrs={'step': '1', 'class': 'slider-number'})
    )

    # NEWS SOURCES

    qNews = models.StringField(
        label='''Which of the following have been your <b>main news sources</b> in
        the last 4 weeks?''',
        choices=[
            'The BBC tv station, Channel 4, ITV, Channel 5',
            'The BBC radio',
            'Other tv stations',
            'Other radio stations',
            'Print or online versions of The Guardian, The Observer, The Economist, i newspaper, Financial Times, or BBC online',
            'Print or online versions of other newspapers and magazines',
            'Government and official news sources',
            'Other online news',
            'Search engines and other websites',
            'Magazines',
            'Friends and family',
            'Social media',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    # RISK

    qCovidRisk = models.StringField(
        label='''What do you think about the risks from COVID-19?''',
        choices=[
            'Most people have no symptoms or only few flu-like symptoms; otherwise COVID-19 isn’t very dangerous.',
            'Only people with several pre-existing conditions die after getting COVID-19 and any of those conditions could have been the reason for their death.',
            'Older members of the population and risk groups can become seriously ill after infection with COVID-19.',
            'Anyone can become seriously ill after infection with COVID-19.',
            'Many people infected with COVID-19 become seriously ill.',
            'Most people infected with COVID-19 become seriously ill.',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qLockdown = models.StringField(
        label='''What do you think about the lockdown to contain the spread of COVID-19?''',
        choices=[
            'There shouldn’t have been any lockdown; it is not clear whether it helps at all.',
            'The lockdown is damaging to the economy and the health benefits of the lockdown do not outweigh the economic risks.',
            'The lockdown is harming the economy the health benefits of the lockdown might not outweigh the economic risks.',
            'The lockdown is necessary to contain the spread of COVID-19.',
            'No measure is too costly to contain the spread of COVID-19.',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qPolicies = models.StringField(
        label='''The policies against the spread of COVID-19 taken by the UK
        government are overall:''',
        choices=[
            'Much too lax',
            'Somewhat too lax',
            'Just right',
            'Somewhat too harsh',
            'Much too harsh',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qCovidManmade = models.StringField(
        label='''With which statement do you agree more?''',
        choices=[
            'The Coronavirus is man-made.',
            'The Coronavirus is natural in origin.',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qCovidOnPurpose = models.StringField(
        label='''With which statement do you agree more?''',
        choices=[
            'The Coronavirus was spread on purpose.',
            'The Coronavirus was spread unintentionally.',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    qCovidOvercome = models.IntegerField(
        label='''When do you think the COVID-19 pandemic will be overcome in the
        UK?''',
        min=0,
        max=999,
        blank=False)

    qVaccine = models.IntegerField(
        label='''When do you think that a vaccination against COVID-19 will be
        widely available in UK?''',
        min=0,
        max=999,
        blank=False)

    qVaccinate = models.StringField(
        label='''When available, will you be willing to get vaccinated against
        COVID-19?''',
        choices=[
            'Definitely not',
            'Probably not',
            'Not sure',
            'Rather yes',
            'Definitely yes',
        ],
        widget=widgets.RadioSelect(),
        blank=False)

    # FEELINGS

    def empathy_questions(label):
        return models.IntegerField(
            label=label,
            blank=False,
            widget=SliderExt(show_value=False,
                             show_labels=True,
                             left_label='Does not describe me very well',
                             right_label='Describes me well'))

    qEmpathy1 = empathy_questions(
        '''I often have tender, concerned feelings for people less fortunate
        than me.'''
    )
    qEmpathy2 = empathy_questions(
        '''Sometimes I <b>don't</b> feel very sorry for other people when they
        are having problems.'''
    )
    qEmpathy3 = empathy_questions(
        '''When I see someone being taken advantage of, I feel kind of
        protective towards them.'''
    )
    qEmpathy4 = empathy_questions(
        '''Other people's misfortunes <b>do not</b> usually disturb me a great
        deal.'''
    )
    qEmpathy5 = empathy_questions(
        '''When I see someone being treated unfairly, I sometimes <b>don't</b>
        feel very much pity for them.'''
    )
    qEmpathy6 = empathy_questions(
        '''I am often quite touched by things that I see happen.'''
    )
    qEmpathy7 = empathy_questions(
        '''I would describe myself as a pretty soft-hearted person.'''
    )
