/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      fontSize: {
        'adaptive-footer-icons': 'clamp(20px, 4.5vh, 40px)', 
        'adaptive-icons': 'clamp(20px, 3vh, 40px)', 
        'adaptive-text': 'clamp(14px, 2vh, 36px)',
        'adaptive-login-header-text': 'clamp(14px, 3.8vh, 100px)',
        'adaptive-button-main-page-text': 'clamp(50px, 10vh, 100px)',
        'adaptive-button-text': 'clamp(14px, 2.5vh, 36px)',
        'adaptive-input-form-text': 'clamp(14px, 1.7vh, 36px)',
        'adaptive-input-form-error-text': 'clamp(11px, 1.5vh, 36px)',

      },
      fontFamily: {
        montserrat: ['Montserrat', 'sans-serif'],
        unbounded: ['Unbounded', 'sans-serif'],
      }
    },
  },
  plugins: [],
  corePlugins: {
    preflight: true,
  },
}

