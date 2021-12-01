<!--

    !!!!!!!!!

    :class="{'hidden':(activeTab !== 4)}"

    !!!!!!!!!

-->

<template>
    <div v-if="!isFrame" :id="id || 'modal'" class="inset-0 z-10 hidden overflow-y-auto transition-opacity opacity-0 modal" aria-labelledby="modal-title" role="dialog" aria-modal="true">
        <div class="flex items-end justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
            <!--
            Background overlay, show/hide based on modal state.

            Entering: "ease-out duration-300"
                From: "opacity-0"
                To: "opacity-100"
            Leaving: "ease-in duration-200"
                From: "opacity-100"
                To: "opacity-0"
            -->
            <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" aria-hidden="true"></div>

            <!-- This element is to trick the browser into centering the modal contents. -->
            <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

            <!--
            Modal panel, show/hide based on modal state.

            Entering: "ease-out duration-300"
                From: "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                To: "opacity-100 translate-y-0 sm:scale-100"
            Leaving: "ease-in duration-200"
                From: "opacity-100 translate-y-0 sm:scale-100"
                To: "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            -->
            <div class="inline-block overflow-hidden text-left align-bottom transition-all transform bg-white rounded-lg shadow-xl sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <div class="px-4 pt-5 pb-4 bg-white sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div v-if="mode=='warning'" class="flex items-center justify-center flex-shrink-0 w-12 h-12 mx-auto bg-yellow-100 rounded-full sm:mx-0 sm:h-10 sm:w-10">
                            <!-- Heroicon name: outline/exclamation -->
                            <svg class="w-6 h-6 text-yellow-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                            </svg>
                        </div>
                        <div v-if="mode=='error'" class="flex items-center justify-center flex-shrink-0 w-12 h-12 mx-auto bg-red-100 rounded-full sm:mx-0 sm:h-10 sm:w-10">
                            <!-- Heroicon name: outline/exclamation-circle -->
                            <svg class="w-6 h-6 text-red-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </div>
                        <div v-if="mode=='success'" class="flex items-center justify-center flex-shrink-0 w-12 h-12 mx-auto bg-green-100 rounded-full sm:mx-0 sm:h-10 sm:w-10">
                            <!-- Heroicon name: outline/check-circle -->
                            <svg class="w-6 h-6 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </div>
                        <div v-if="mode=='info'" class="flex items-center justify-center flex-shrink-0 w-12 h-12 mx-auto bg-blue-100 rounded-full sm:mx-0 sm:h-10 sm:w-10">
                            <!-- Heroicon name: outline/information-circle -->
                            <svg class="w-6 h-6 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </div>
                        <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                            <h3 class="text-lg font-medium leading-6 text-gray-900 modal-title" v-if="title">
                            {{ title }}
                            </h3>
                            <div class="mt-2">
                            <p class="text-sm text-gray-500" v-html="text" v-if="isHTML"></p>
                            <p class="text-sm text-gray-500" v-if="!isHTML">
                            {{ text }}
                            </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="px-4 py-3 bg-gray-50 sm:px-6 sm:flex sm:flex-row-reverse">
                    <button @click="modalConfirm(id)" v-if="mode == 'warning' && button" type="button" class="inline-flex justify-center w-full px-4 py-2 text-base font-medium text-white bg-yellow-500 border border-transparent rounded-md shadow-sm hover:bg-yellow-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500 sm:ml-3 sm:w-auto sm:text-sm">
                    {{ button }}
                    </button>
                    <button @click="modalConfirm(id)" v-if="mode == 'error' && button" type="button" class="inline-flex justify-center w-full px-4 py-2 text-base font-medium text-white bg-red-600 border border-transparent rounded-md shadow-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                    {{ button }}
                    </button>
                    <button @click="modalConfirm(id)" v-if="mode == 'success' && button" type="button" class="inline-flex justify-center w-full px-4 py-2 text-base font-medium text-white bg-green-600 border border-transparent rounded-md shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 sm:ml-3 sm:w-auto sm:text-sm">
                    {{ button }}
                    </button>
                    <button @click="modalConfirm(id)" v-if="mode == 'info' && button" type="button" class="inline-flex justify-center w-full px-4 py-2 text-base font-medium text-white bg-blue-600 border border-transparent rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm">
                    {{ button }}
                    </button>
                    <button @click="modalDecline(id)" v-if="cancel" type="button" class="inline-flex justify-center w-full px-4 py-2 mt-3 text-base font-medium text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    {{ cancel }}
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div v-if="isFrame" :id="id ||' modal'" class="hidden overflow-y-auto transition-opacity opacity-0 frame-modal">
        <div id="modalClose" @click="modalConfirm(id)">schließen <span class="x">&times;</span></div>
        <div class="spinner"></div>
        <iframe id="modalFrame" :src="frameSrc" frameborder="0"></iframe>
    </div>
</template>


<script>
export default {
    name: 'Modal',
    props: {
        id: String,
        title: String,
        text: String,
        isHTML: Boolean,
        button: String,
        cancel: String,
        mode: String,
        isFrame: Boolean,
        frameSrc: String,
        callback: Function
    },
    methods: {
        fadeIn: function(modalId) {
            modalId = modalId || 'modal';
            let modalElmt = document.querySelector('#' + modalId);
            modalElmt.classList.add('fixed', 'ease-out', 'duration-300');
            modalElmt.classList.remove('hidden');
            setTimeout(function() {
                modalElmt.classList.replace('opacity-0', 'opacity-100');
            }, 1);
        },
        fadeOut: function(modalId) {
            modalId = modalId || 'modal';
            let modalElmt = document.querySelector('#' + modalId);
            modalElmt.classList.remove('opacity-100');
            modalElmt.classList.add('opacity-0', 'ease-in', 'duration-200');
            setTimeout(function() {
                modalElmt.classList.add('hidden');
                modalElmt.classList.remove('fixed');
            }, 200);
        },
        modalConfirm: function(modalId) {
            this.fadeOut(modalId);
            if (this.callback) this.callback(true);
        },
        modalDecline: function(modalId) {
            this.fadeOut(modalId);
            if (this.callback) this.callback(false);
        },
    }
}
</script>


<style lang="scss" scoped>
.frame-modal {
    --clr-turquoise: #5CC8C5;
    --clr-turquoise-dark: #52A3A1;
    --clr-white: #fff;
    --clr-secondary: var(--clr-turquoise);
    --clr-secondary-dark: var(--clr-turquoise-dark);
    --border-radius: 4px;

    z-index: 9999;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: var(--clr-white);

    #modalClose {
        position: fixed;
        top: 20px;
        right: 20px;
        cursor: pointer;
        color: var(--clr-white);
        background-color: var(--clr-secondary);
        padding: 5px 10px;
        border-radius: var(--border-radius);

        &:active {
            background-color: var(--clr-secondary-dark);
        }
    }

    .spinner {
        z-index: -1;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    iframe#modalFrame {
        width: 100%;
        height: 100%;
    }
}
</style>