import axios from 'axios';
import { API_URL } from '../config/constants.config';

class UserService {
  /**
   * @param {String} token 
   * @param {object} body 
   * @returns 
   */
  create(token, body) {
    return axios.post(`${API_URL}/users`, {
      'user': {
        'username': body.username,
        'email': body.email
      }
    }, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {number} id 
   * @returns 
   */
  findOne(token, id) {
    return axios.get(`${API_URL}/users/${id}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @returns 
   */
  findAll(token) {
    return axios.get(`${API_URL}/users`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {String} email 
   * @returns 
   */
  findByEmail(token, email) {
    return axios.get(`${API_URL}/users?email=${email}`,{
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {String} username 
   * @returns 
   */
  findByUsername(token, username) {
    return axios.get(`${API_URL}/users?username=${username}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {String} username 
   * @param {String} email 
   * @returns 
   */
  findByUsernameAndEmail(token, username, email) {
    return axios.get(`${API_URL}/users?username=${username}&email=${email}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {number} id 
   * @param {object} body 
   * @returns 
   */
  update(token, id, body) {
    console.log(body);
    return axios.put(`${API_URL}/users/${id}`, {
      'user': {
        'username': body.username,
        'email': body.email,
        'password': body.password,
        'role': body.role
      }
    }, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {number} id 
   * @returns 
   */
  delete(token, id) {
    return axios.delete(`${API_URL}/users/${id}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }
}

export default new UserService();