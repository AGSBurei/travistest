import axios from 'axios';
import { API_URL } from '../config/constants.config';

class UserService {
  create(body) {
    return axios.post(`${API_URL}/users`, {
      'user': {
        'username': body.username,
        'email': body.email
      }
    });
  }

  findOne(id) {
    return axios.get(`${API_URL}/users/${id}`);
  }

  findAll() {
    return axios.get(`${API_URL}/users`);
  }

  update(id, body) {
    return axios.put(`${API_URL}/users/${id}`, {
      'user': {
        'username': body.username,
        'email': body.email
      }
    });
  }

  delete(id) {
    return axios.delete(`${API_URL}/users/${id}`);
  }
}

export default new UserService();