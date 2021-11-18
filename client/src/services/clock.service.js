import axios from 'axios';
import { API_URL } from '../config/constants.config';

class ClockService {
  /**
   * 
   * @param {String} token 
   * @param {number} userID 
   * @param {object} body 
   * @returns 
   */
  create(token, userID, body) {
    return axios.post(`${API_URL}/clocks/${userID}`, {
      'clock': {
        'time': body.time,
        'status': body.status
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
    return axios.get(`${API_URL}/clocks/${userID}`, {
      'headers': {
        'Authorization': `Bearer ${token}`
      }
    });
  }
}

export default new ClockService();