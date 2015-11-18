from django.http import JsonResponse
from rest_framework.views import APIView

from ..serializers import UserSerializer


class AuthView(APIView):
  def get(self, request):
    user = request.user
    if user.is_authenticated():
      data = UserSerializer(user).data
      data['is_authenticated'] = True
    else:
      data = {'is_authenticated': False}
    return JsonResponse(data)
