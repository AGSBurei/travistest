<template>
  <div class="chip">
  <Avatar :username="user.username" />
  <div class="chip-content">{{user.username}}</div>
    <div class="dropdown" v-if="withOption">
      <a class="btn">
        <div class="chip-close">
          <svg
            class="chip-svg rotating"
            focusable="false"
            viewBox="0 0 24 24"
            aria-hidden="true"
          >
            <g>
              <path d="M0,0h24v24H0V0z" fill="none" />
              <path
                d="M19.14,12.94c0.04-0.3,0.06-0.61,0.06-0.94c0-0.32-0.02-0.64-0.07-0.94l2.03-1.58c0.18-0.14,0.23-0.41,0.12-0.61 l-1.92-3.32c-0.12-0.22-0.37-0.29-0.59-0.22l-2.39,0.96c-0.5-0.38-1.03-0.7-1.62-0.94L14.4,2.81c-0.04-0.24-0.24-0.41-0.48-0.41 h-3.84c-0.24,0-0.43,0.17-0.47,0.41L9.25,5.35C8.66,5.59,8.12,5.92,7.63,6.29L5.24,5.33c-0.22-0.08-0.47,0-0.59,0.22L2.74,8.87 C2.62,9.08,2.66,9.34,2.86,9.48l2.03,1.58C4.84,11.36,4.8,11.69,4.8,12s0.02,0.64,0.07,0.94l-2.03,1.58 c-0.18,0.14-0.23,0.41-0.12,0.61l1.92,3.32c0.12,0.22,0.37,0.29,0.59,0.22l2.39-0.96c0.5,0.38,1.03,0.7,1.62,0.94l0.36,2.54 c0.05,0.24,0.24,0.41,0.48,0.41h3.84c0.24,0,0.44-0.17,0.47-0.41l0.36-2.54c0.59-0.24,1.13-0.56,1.62-0.94l2.39,0.96 c0.22,0.08,0.47,0,0.59-0.22l1.92-3.32c0.12-0.22,0.07-0.47-0.12-0.61L19.14,12.94z M12,15.6c-1.98,0-3.6-1.62-3.6-3.6 s1.62-3.6,3.6-3.6s3.6,1.62,3.6,3.6S13.98,15.6,12,15.6z"
              />
            </g>
          </svg>
        </div>
      </a>
      <div class="dropdown-content">
        <a @click.prevent="passToParentEvent({template: 'template_update', user: user})" href="#">Edit</a>
        <a @click.prevent="passToParentEvent({template: 'template_delete', user: user})" href="#">Delete</a>
      </div>
    </div>
  </div>
</template>

<script>
import Avatar from './Avatar.vue';

export default {
  name: "UserChip",
  props: ["user", "withOption"],
  components: {
    Avatar
  },
  methods: {
    passToParentEvent (args) {
      this.$emit('changeCurrentTemplate', args);
    },
    printFirstChar (value) {
      return value.charAt(0);
    },
    randomColorByUsername (username) {
      let hash = 0;
      for (let i = 0; i < username.length; i++) {
        hash = username.charCodeAt(i) + ((hash << 5) - hash);
      }
      let colour = "#";
      for (let i = 0; i < 3; i++) {
        let value = (hash >> (i * 8)) & 0xff;
        colour += ("00" + value.toString(16)).substr(-2);
      }
      return colour;
    }
  }
};
</script>

<style scoped>
.chip {
  display: inline-flex;
  flex-direction: row;
  background-color: #e5e5e5;
  border: none;
  cursor: default;
  height: 36px;
  outline: none;
  padding: 0;
  font-size: 14px;
  color: #333333;
  font-family: "Open Sans", sans-serif;
  white-space: nowrap;
  align-items: center;
  border-radius: 16px;
  vertical-align: middle;
  text-decoration: none;
  justify-content: center;
  margin: 0.15rem;
}
.chip-content {
  cursor: inherit;
  display: flex;
  align-items: center;
  user-select: none;
  white-space: nowrap;
  padding-left: 12px;
  padding-right: 12px;
}
.chip-svg {
  color: #999999;
  cursor: pointer;
  height: auto;
  margin: 4px 4px 0 -8px;
  fill: currentColor;
  width: 1em;
  height: 1em;
  display: inline-block;
  font-size: 24px;
  transition: fill 200ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
  user-select: none;
  flex-shrink: 0;
}
.chip-svg:hover {
  color: #666666;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
  background-color: #ddd;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
  display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.btn:hover,
.dropdown:hover .btn {
  background-color: #ebebeb;
}







.rotating {
  transition: transform 1s ease-in-out;
}
.rotating:hover {
  transform: rotateZ(360deg);
}
</style>