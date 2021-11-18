import axios from 'axios';
import { API_URL } from '../config/constants.config';

class WorkingTimeService {
  /**
   * @param {String} token 
   * @param {number} userID 
   * @param {object} body 
   * @returns 
   */
  create(token, userID, body) {
    return axios.post(`${API_URL}/workingtimes/${userID}`, {
      'workingtime': {
        'start': body.start,
        'end': body.end
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
   * @param {object} body 
   * @returns 
   */
  update(token, id, body) {
    return axios.put(`${API_URL}/workingtimes/${id}`, {
      'workingtime': {
        'start': body.start,
        'end': body.end
      }
    }, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {number} userID 
   * @returns 
   */
  findAll(token, userID) {
    return axios.get(`${API_URL}/workingtimes/${userID}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }

  /**
   * @param {String} token 
   * @param {number} userID 
   * @param {number} id 
   * @returns 
   */
  findOne(token, userID, id) {
    return axios.get(`${API_URL}/workingtimes/${userID}/${id}`, {
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
    return axios.delete(`${API_URL}/workingtimes/${id}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }
}

export default new WorkingTimeService();