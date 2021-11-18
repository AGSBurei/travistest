import axios from 'axios';
import { API_URL } from '../config/constants.config';

class AuthService {
  login(user) {
    return axios.post(`${API_URL}/users/signin`, {
      'email': user.email,
      'password': user.password
    })
    .then(response => {
      if (response.data.data.token) {
        localStorage.setItem('user', JSON.stringify(response.data.data));
      }

      return response.data.data;
    });
  }

  register(user) {
    return axios.post(`${API_URL}/users/signup`, {
      'user': {
        'username': user.username,
        'email': user.email,
        'password': user.password
      }
    });
  }

  logout() {
    localStorage.removeItem('user');
  }
}

export default new AuthService();