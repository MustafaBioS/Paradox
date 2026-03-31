<script>
    let isOpen = $state(false);

    let book;
    let faq;

    function animateBook() {
        if (isOpen === false) {
            book.classList.add("openBook");
            faq.style.display = "flex";
            isOpen = true;
        }
    }
</script>

<main class="main w-full min-h-screen relative">

    <div class="absolute top-0 left-0 p-4 sm:p-6">
        <button onclick={() => (window.location.href = "/")}>
            <img
                    src="/images/faq/faq-btn.png"
                    class="min-w-52 w-64 max-w-[20vw] transition-all duration-300 ease-in-out hover:opacity-60 cursor-pointer"
                    alt="Home Button"
            />
        </button>
    </div>

    <button class="absolute bottom-0 left-1/2 -translate-x-1/2" onclick={animateBook}>
        <img
                bind:this={book}
                src="/images/faq/faq-book.png"
                class="min-w-[20rem] w-[50rem] max-w-[45vw] transition-all duration-300 ease-in-out hover:opacity-80 cursor-pointer"
                alt="FAQ Playbook"
        />
    </button>

    <div class="absolute bottom-0 left-1/2 -translate-x-1/2 flex flex-row hidden" bind:this={faq}>
        <div
            class="bg-white min-h-[20rem] h-[50rem] min-w-[20rem] w-[38rem] max-w[42rem] border-r-2 border-black rounded-lg p-10"
        >
            <div class="h-4 w-[100%] bg-black"></div>
            <div class="h-1 w-[100%] bg-black mt-2"></div>
            <h1 style="font-family: 'Bethany, serif'" class="text-8xl">FAQ</h1>
            <div class="h-1 w-[30%] bg-black mt-5"></div>
            <h1 class="text-4xl mt-6" style="font-family: 'Bethany', serif">Question #1 .........................</h1>
            <h1 class="text-4xl mt-6" style="font-family: 'Bethany', serif">Question #1 .........................</h1>
            <h1 class="text-4xl mt-6" style="font-family: 'Bethany', serif">Question #1 .........................</h1><br>
            <h1 class="text-4xl mt-6" style="font-family: 'Bethany', serif">Question #1 .........................</h1>
            <h1 class="text-4xl mt-6" style="font-family: 'Bethany', serif">Question #1 .........................</h1>
            <h1 class="text-4xl mt-6" style="font-family: 'Bethany', serif">Question #1 .........................</h1>
            <div class="h-1 w-[30%] bg-black mt-12"></div>
            <div class="flex flex-row items-center gap-3 mt-16">
                <img
                    src="images/faq/faq-logo.png"
                    alt="Paradox Logo"
                />
                <img
                        src="images/faq/faq-star.png"
                        alt="Star"
                        class="object-contain"
                />
                <h1
                    class="text-4xl"
                    style="font-family: 'Bethany', serif"
                >
                    Hack Club 2026
                </h1>
            </div>
        </div>
        <div class="bg-white min-h-[20rem] h-[50rem] min-w-[20rem] w-[38rem] max-w[42rem] rounded-lg p-10">
            <div class="flex flex-row items-center">
                <div class="flex flex-col items-center w-full">
                    <div class="h-4 w-[75%] bg-black"></div>
                    <div class="h-1 w-[75%] bg-black mt-2"></div>
                </div>
                <h1
                        class="text-6xl"
                        style="font-family: 'Bethany', serif"
                >
                    ANSWER
                </h1>
                <div class="flex flex-col items-center w-full">
                    <div class="h-4 w-[75%] bg-black"></div>
                    <div class="h-1 w-[75%] bg-black mt-2"></div>
                </div>
            </div>

            <div class="h-1 w-[100%] bg-black mt-6"></div>

                <h1
                    class="text-2xl text-center mt-14"
                    style="font-family: 'Bethany', serif"
                >
                     answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer answer
                </h1>

            <div class="flex flex-col h-[52%] items-end justify-end">
                <div class="h-1 w-[100%] bg-black"></div>

                <div class="flex flex-row items-center w-full mt-4">
                    <div class="flex-col flex w-full justify-between">
                        <p
                                class="text-lg"
                                style="font-family: 'Bethany', serif"
                        >
                            produced by
                        </p>
                        <a
                                href="https://hackclub.com"
                                class="text-3xl"
                                style="font-family: 'Bethany', serif"
                        >
                            Hack Club
                        </a>
                    </div>
                    <div class="flex-col w-full flex items-end justify-end">
                        <p
                                class="text-lg"
                                style="font-family: 'Bethany', serif"
                        >
                            directed by teens
                        </p>
                        <div class="flex flex-row">
                            <p
                                    class="text-3xl"
                                    style="font-family: 'Bethany', serif"
                            >
                                for teens
                            </p>
                            <img
                                    src="/images/faq/faq-star.png"
                                    class="ml-2"
                                    alt="Star"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>


<style>
    .main {
        background-image: url("/images/faq/faq-bg.png");
        background-attachment: fixed;
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
    }
</style>