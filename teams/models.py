import arrow
from django.db import models
from django.utils.translation import ugettext_lazy as _

from common.models import User


class Teams(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    users = models.ManyToManyField(User, related_name='user_teams')
    created_on = models.DateTimeField(_("Created on"), auto_now_add=True)
    created_by = models.ForeignKey(
        User, related_name='teams_created', blank=True, null=True, on_delete=models.SET_NULL)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('id',)

    @property
    def created_on_arrow(self):
        return arrow.get(self.created_on).humanize()

    def get_users(self):
        return list(self.users.values_list('id', flat=True))
