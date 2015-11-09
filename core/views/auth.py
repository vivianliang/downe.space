from rest_framework.views import APIView
from ..serializers import UserSerializer
from ..utils import render_json


class AuthView(APIView):
  def get(self, request):
    user = request.user
    if user.is_authenticated():
      data = UserSerializer(user).data
      data['is_authenticated'] = True
    else:
      data = {'is_authenticated': False}
    return render_json(data)
