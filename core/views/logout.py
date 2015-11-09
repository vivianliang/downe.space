from rest_framework.views import APIView
from django.shortcuts import redirect
from django.contrib.auth import logout as auth_logout


class LogoutView(APIView):
  def get(self, request):
    auth_logout(request)
    return redirect('/')
