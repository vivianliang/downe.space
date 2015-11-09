from rest_framework.views import APIView
from ..utils import render_json


class AuthView(APIView):
  def get(self, request):
    print request.user
    user = request.user
    data = {
      'username': user.username,
      'first_name': user.first_name,
      'last_name': user.last_name,
      'name': user.get_full_name()
    }
    return render_json(data)
