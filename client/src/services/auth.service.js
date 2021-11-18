import axios from 'axios';
import { API_URL } from '../config/constants.config';

class AuthService {
  /**
   * @param {object} body 
   * @returns 
   */
  login(body) {
    return axios.post(`${API_URL}/users/signin`, {
      'email': body.email,
      'password': body.password
    })
    .then(response => {
      if (response.data.data.token) {
        localStorage.setItem('user', JSON.stringify(response.data.data));
      }

      return response.data.data;
    });
  }

  /**
   * @param {object} body 
   * @returns 
   */
  register(body) {
    return axios.post(`${API_URL}/users/signup`, {
      'user': {
        'username': body.username,
        'email': body.email,
        'password': body.password
      }
    });
  }

  logout() {
    localStorage.removeItem('user');
  }

  /**
   * @param {array} authorizedRoles 
   * @returns 
   */
  hasRole(authorizedRoles) {
    const user = this.$store.state.auth.user;
    if (authorizedRoles && user && authorizedRoles.includes(user.role)) {
      return true;
    }
    return false;
  }
}

export default new AuthService();