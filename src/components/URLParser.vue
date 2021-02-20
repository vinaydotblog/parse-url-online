<template>
    <h2 class="text-4xl pb-2">Enter URL to Parse</h2>
    <input class="input input-large" @input="parse" v-model="longUrl" autofocus/>
    <button class="btn" @click="parse">Parse</button>
    <div class="url-container">
        <div :class="part.block ? 'block': ''" class="url-part" v-for="(part, index) in parts" :key="index" @click="copy(part)">
            <span class="url-value" :class="'bg-' + part.color + '-500'">
                <span v-if="part.label" class="url-label">{{part.label}}</span>
                {{part.value}}
            </span>
        </div>
    </div>


<div class=" alert">
<div v-if="showSuccess" class="flex-1 flex-col fade w-full mr-8 justify-end pointer-events-none"><div class="flex py-1 w-full transform transition-all duration-300 pointer-events-auto"><div class="flex w-full visible flex-row shadow-lg border-l-4 rounded-md duration-100 cursor-pointer transform transition-all hover:scale-102 bg-white border-green-500 max-h-40"><div class="flex flex-row p-2 flex-no-wrap w-full"><div class="flex items-center h-12 w-8 mr-3 mx-auto text-xl select-none"><svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" class="svg-inline--fa fa-check fa-w-16 mx-auto text-green-500 " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"></path></svg></div><div class="flex flex-col flex-no-wrap px-1 w-full"><div class="flex my-auto font-bold select-none">Success</div><p class="-mt-0.5 my-auto break-all flex text-gray-600 text-sm truncate-1-lines" v-html="showSuccess"></p></div><div class="w-10 h-12 mr-2 items-center mx-auto text-center leading-none text-lg"></div></div></div></div></div>
</div>
</template>

<script>
export default {
    data(){
        return {
            parts: [],
            longUrl: '',
            showSuccess: false,
        }
    },

    created(){
        this.longUrl = 'https://somelongurl.example.com/path/subdir/html-file.php?fname=John&lname=doe#bookmark-heading';
        this.parse();
    },

    methods: {
        parse(){
            let url = new URL(this.longUrl)
            console.log(url);
            let parts = [
                { label: 'Protocol', value: url.protocol, color: 'yellow' },
                { label: '', value: '//', color: 'yellow' },
                { label: 'Credentials', value: url.username ? (url.username + ':' + url.password + '@') : '', color: 'purple' },
                { label: 'Host', value: url.hostname, color: 'blue' },
                { label: 'Path', value: url.pathname, color: 'red', block: true },   
            ]
            
            if(url.search) {
                url.searchParams.forEach((value, param) => {
                    parts.push({
                        'label': 'Query: ' + param,
                        'value': value,
                        'color': 'green',
                        'block': true
                    });
                });
            }

            parts.push({ label: 'Hash', value: url.hash, color: 'pink' });

            this.parts = parts.filter(a => a.value)
        },

        copy: async function(part) {
            await navigator.clipboard.writeText(part.value)

            this.showSuccess = `Value of&nbsp;<b>${part.label}</b>&nbsp;was copied to clipboard`;
            setTimeout(() => this.showSuccess = false, 2000)
        }
    }
}
</script>
<style>
    .only-for-compiler-to-see {
        @apply bg-pink-500 bg-yellow-500 bg-blue-500 bg-red-500 bg-green-500 bg-purple-500 bg-indigo-500;
    }
    .input {
        @apply placeholder-gray-400 text-gray-700 bg-white rounded text-base shadow  outline-none w-full;
    }
    .input-large {
        @apply px-3 py-4 relative;
    }

    .btn {
        @apply my-5 mr-2 py-2 px-4 bg-indigo-500 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:ring-opacity-75;

    }

    .url-container {
        @apply mt-2 p-2 bg-blue-100 pb-10 shadow-md;
    }

    .url-part {
        @apply  my-8;
        display: inline;
        position: relative;
    }

    .url-value {
        @apply bg-blue-400 m-0.5 mt-10 text-white px-1 rounded text-2xl inline-block cursor-pointer break-all;
    }

    .url-value:hover {
        @apply opacity-80;
    }

    .url-label {
        @apply bg-blue-400 text-base rounded px-1 shadow-lg;
        position: absolute;
        top: 100%;
        left: 0;
        display: inline;
    }
    .alert {
        @apply fixed;
        top: 10px;
        right: 10px;
    }
    </style>
