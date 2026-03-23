// =============================================================
//  Microtex — tailwind.config.js
//  Place this file in: ~/Scripts/tailwind.config.js
//  Loaded by index.aspx after the Tailwind CDN script.
// =============================================================

tailwind.config = {
    darkMode: "class",
    theme: {
        extend: {
            colors: {
                "primary": "#ede8cf",
                "secondary": "#d9d4bb",
                "accent": "#8f8a7a",
                "dark-neutral": "#4f4c44",
                "background-light": "#f8f7f6",
                "background-dark": "#1e1c14",
            },
            fontFamily: {
                "display": ["Inter", "sans-serif"]
            },
            borderRadius: {
                "DEFAULT": "0.25rem",
                "lg": "0.5rem",
                "xl": "0.75rem",
                "full": "9999px"
            },
        },
    },
};