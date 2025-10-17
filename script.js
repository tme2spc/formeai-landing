// ================================================
// Smooth Scroll Animation with Intersection Observer
// ================================================

/**
 * Intersection Observer for fade-up animations
 */
const observeElements = () => {
    const fadeUpElements = document.querySelectorAll('.fade-up');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    });
    
    fadeUpElements.forEach(element => {
        observer.observe(element);
    });
};

// ================================================
// Scroll to Top Button
// ================================================

/**
 * Show/Hide scroll to top button based on scroll position
 */
const initScrollTopButton = () => {
    const scrollTopBtn = document.getElementById('scroll-top');
    
    if (!scrollTopBtn) return;
    
    window.addEventListener('scroll', () => {
        if (window.pageYOffset > 300) {
            scrollTopBtn.classList.add('visible');
        } else {
            scrollTopBtn.classList.remove('visible');
        }
    });
    
    scrollTopBtn.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
};

// ================================================
// Form Validation
// ================================================

/**
 * Validate email format
 */
const isValidEmail = (email) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
};

/**
 * Validate phone number format (Korean format)
 */
const isValidPhone = (phone) => {
    const phoneRegex = /^01[0-9]-?[0-9]{3,4}-?[0-9]{4}$/;
    return phoneRegex.test(phone.replace(/\s/g, ''));
};

/**
 * Show error message for a form field
 */
const showError = (input, message) => {
    const formGroup = input.closest('.form-group');
    const errorMessage = formGroup.querySelector('.error-message');
    
    input.style.borderColor = 'var(--accent)';
    errorMessage.textContent = message;
    errorMessage.style.display = 'block';
};

/**
 * Clear error message for a form field
 */
const clearError = (input) => {
    const formGroup = input.closest('.form-group');
    if (!formGroup) return;
    
    const errorMessage = formGroup.querySelector('.error-message');
    
    input.style.borderColor = 'var(--light-gray)';
    if (errorMessage) {
        errorMessage.textContent = '';
        errorMessage.style.display = 'none';
    }
};

/**
 * Validate individual form field
 */
const validateField = (input) => {
    const value = input.value.trim();
    const fieldName = input.name;
    
    // Clear previous error
    clearError(input);
    
    // Check if required field is empty
    if (input.hasAttribute('required') && !value) {
        showError(input, '필수 입력 항목입니다.');
        return false;
    }
    
    // Validate specific fields
    switch (fieldName) {
        case 'name':
            if (value.length < 2) {
                showError(input, '이름은 2자 이상 입력해주세요.');
                return false;
            }
            break;
            
        case 'email':
            if (value && !isValidEmail(value)) {
                showError(input, '올바른 이메일 형식을 입력해주세요.');
                return false;
            }
            break;
            
        case 'phone':
            if (value && !isValidPhone(value)) {
                showError(input, '올바른 전화번호 형식을 입력해주세요. (예: 010-1234-5678)');
                return false;
            }
            break;
            
        case 'service':
            if (!value) {
                showError(input, '관심 서비스를 선택해주세요.');
                return false;
            }
            break;
            
        case 'message':
            if (value.length < 10) {
                showError(input, '문의 내용은 10자 이상 입력해주세요.');
                return false;
            }
            break;
    }
    
    return true;
};

/**
 * Initialize contact form validation and submission
 */
const initContactForm = () => {
    const form = document.getElementById('contact-form');
    
    if (!form) return;
    
    // Real-time validation on blur
    const inputs = form.querySelectorAll('input[required], textarea[required], select[required]');
    inputs.forEach(input => {
        input.addEventListener('blur', () => {
            validateField(input);
        });
        
        input.addEventListener('input', () => {
            if (input.style.borderColor === 'var(--accent)') {
                clearError(input);
            }
        });
        
        // Also add change event for select elements
        if (input.tagName === 'SELECT') {
            input.addEventListener('change', () => {
                if (input.style.borderColor === 'var(--accent)') {
                    clearError(input);
                }
            });
        }
    });
    
    // Checkbox validation
    const privacyCheckbox = document.getElementById('privacy');
    if (privacyCheckbox) {
        privacyCheckbox.addEventListener('change', () => {
            const formGroup = privacyCheckbox.closest('.form-group');
            const errorMessage = formGroup.querySelector('.error-message');
            
            if (privacyCheckbox.checked) {
                errorMessage.textContent = '';
            }
        });
    }
    
    // Form submission
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        // Validate all fields
        let isValid = true;
        const formInputs = form.querySelectorAll('input:not([type="checkbox"]), textarea, select');
        
        formInputs.forEach(input => {
            if (!validateField(input)) {
                isValid = false;
            }
        });
        
        // Check privacy checkbox
        const privacyCheckbox = document.getElementById('privacy');
        if (privacyCheckbox && !privacyCheckbox.checked) {
            const formGroup = privacyCheckbox.closest('.form-group');
            const errorMessage = formGroup.querySelector('.error-message');
            errorMessage.textContent = '개인정보 수집 및 이용에 동의해주세요.';
            isValid = false;
        }
        
        if (!isValid) {
            // Scroll to first error
            const firstError = form.querySelector('.error-message:not(:empty)');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            return;
        }
        
        // Get form data
        const formData = {
            name: form.name.value.trim(),
            phone: form.phone.value.trim(),
            email: form.email.value.trim(),
            service: form.service.value.trim(),
            company: form.company.value.trim(),
            message: form.message.value.trim(),
        };
        
        // Show loading state
        const submitButton = form.querySelector('button[type="submit"]');
        const originalText = submitButton.textContent;
        submitButton.textContent = '전송 중...';
        submitButton.disabled = true;
        
        try {
            // Simulate API call (replace with actual API endpoint)
            await new Promise(resolve => setTimeout(resolve, 1500));
            
            // Success
            alert('상담 신청이 완료되었습니다!\n빠른 시일 내에 연락드리겠습니다.');
            form.reset();
            
            // Log to console (in production, send to server)
            console.log('Form submitted:', formData);
            
        } catch (error) {
            // Error handling
            alert('전송 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.');
            console.error('Form submission error:', error);
            
        } finally {
            // Reset button state
            submitButton.textContent = originalText;
            submitButton.disabled = false;
        }
    });
};

// ================================================
// Smooth Scroll for Anchor Links
// ================================================

/**
 * Initialize smooth scrolling for anchor links
 */
const initSmoothScroll = () => {
    const links = document.querySelectorAll('a[href^="#"]');
    
    links.forEach(link => {
        link.addEventListener('click', (e) => {
            const href = link.getAttribute('href');
            
            // Skip empty hash or hash-only links
            if (href === '#' || href === '#!') {
                return;
            }
            
            const target = document.querySelector(href);
            
            if (target) {
                e.preventDefault();
                
                const offsetTop = target.offsetTop - 80; // Account for fixed header if any
                
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });
};

// ================================================
// Phone Number Auto-formatting
// ================================================

/**
 * Auto-format phone number input
 */
const initPhoneFormatting = () => {
    const phoneInput = document.getElementById('phone');
    
    if (!phoneInput) return;
    
    phoneInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/[^0-9]/g, '');
        
        if (value.length > 11) {
            value = value.slice(0, 11);
        }
        
        if (value.length > 6) {
            value = value.replace(/(\d{3})(\d{3,4})(\d{4})/, '$1-$2-$3');
        } else if (value.length > 3) {
            value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
        }
        
        e.target.value = value;
    });
};

// ================================================
// Parallax Effect for Hero Section
// ================================================

/**
 * Add subtle parallax effect to hero section
 */
const initParallaxEffect = () => {
    const heroSection = document.querySelector('.hero-section');
    
    if (!heroSection) return;
    
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        const parallaxSpeed = 0.5;
        
        if (scrolled < window.innerHeight) {
            heroSection.style.transform = `translateY(${scrolled * parallaxSpeed}px)`;
        }
    });
};

// ================================================
// Active Section Highlight (for navigation)
// ================================================

/**
 * Highlight current section in navigation (if navigation exists)
 */
const initActiveSectionHighlight = () => {
    const sections = document.querySelectorAll('section[id]');
    
    if (sections.length === 0) return;
    
    window.addEventListener('scroll', () => {
        const scrollPosition = window.pageYOffset + 100;
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                // Remove active class from all links
                document.querySelectorAll(`a[href="#${sectionId}"]`).forEach(link => {
                    link.classList.add('active');
                });
            } else {
                document.querySelectorAll(`a[href="#${sectionId}"]`).forEach(link => {
                    link.classList.remove('active');
                });
            }
        });
    });
};

// ================================================
// Performance: Debounce Function
// ================================================

/**
 * Debounce function to limit function calls
 */
const debounce = (func, wait) => {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
};

// ================================================
// Initialize All Functions on DOM Load
// ================================================

document.addEventListener('DOMContentLoaded', () => {
    // Initialize all features
    observeElements();
    initScrollTopButton();
    initContactForm();
    initSmoothScroll();
    initPhoneFormatting();
    initParallaxEffect();
    initActiveSectionHighlight();
    
    console.log('🚀 포미서비스 랜딩 페이지가 로드되었습니다.');
});

// ================================================
// Page Load Performance
// ================================================

window.addEventListener('load', () => {
    // Add loaded class to body for any CSS transitions
    document.body.classList.add('loaded');
    
    // Log performance metrics (optional)
    if (window.performance) {
        const perfData = window.performance.timing;
        const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;
        console.log(`⚡ 페이지 로드 시간: ${pageLoadTime}ms`);
    }
});

// ================================================
// Export functions for testing (if needed)
// ================================================

if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        isValidEmail,
        isValidPhone,
        validateField,
        debounce
    };
}

