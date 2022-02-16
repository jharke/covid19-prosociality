from otree.api import widgets


class SliderExt(widgets.Slider):

    def __init__(self, *args, show_labels=True, left_label='disagree',
                 right_label='agree', **kwargs):
        super().__init__(*args, **kwargs)
        if 'show_value' in kwargs:
            self.show_value = kwargs['show_value']
        self.show_labels = show_labels
        self.left_label = left_label
        self.right_label = right_label
        self.template_name = 'widgets/slider.html'

    def get_context(self, *args, **kwargs):
        context = super().get_context(*args, **kwargs)
        context['show_labels'] = self.show_labels
        context['left_label'] = self.left_label
        context['right_label'] = self.right_label
        return context
