/**
 * Modal
 */
const modal = {
    init: () => {
        modal.elmt.self = document.querySelector('#modal');
        modal.elmt.close = document.querySelector('#modalClose');
        modal.elmt.frame = document.querySelector('#modalFrame');
    },
    elmt: {
        self: null,
        close: null,
        frame: null
    },
    open: event => {
        let href = event.target.href;

        event.preventDefault();
        modal.elmt.frame.src = href;

        document.body.classList.add('disable-scroll');
        fade.in(modal.elmt.self);
    },
    close: () => {
        document.body.classList.remove('disable-scroll');
        fade.out(modal.elmt.self, () => modal.elmt.frame.src = '');
    }
}


/**
 * Animation (Fade)
 */
const fade = {
    out: (elmt, callback) => {
        elmt.style.opacity = 1;
        (function fade() {
            var val = parseFloat(elmt.style.opacity);
            if (!((val -= .1) < 0)) {
                elmt.style.opacity = val;
                requestAnimationFrame(fade);
            } else {
                elmt.style.display = 'none';
                if (callback) callback();
            }
        })();
        return true;
    },
    in: (elmt, display) => {
        elmt.style.opacity = 0;
        elmt.style.display = display || 'block';
        (function fade() {
            var val = parseFloat(elmt.style.opacity);
            if (!((val += .1) >= 1)) {
                elmt.style.opacity = val;
                requestAnimationFrame(fade);
            } else {
                elmt.style.opacity = 1;
            }
        })();
    }
}


window.onload = modal.init;