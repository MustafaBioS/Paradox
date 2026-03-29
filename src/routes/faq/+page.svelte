<script>
    let isOpen = $state(false);
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

    <div class="absolute bottom-0 left-1/2 -translate-x-1/2">
        <img
                src="/images/faq/faq-book.png"
                class="min-w-[20rem] w-[50rem] max-w-[45vw] transition-all duration-300 ease-in-out hover:opacity-80 cursor-pointer"
                alt="FAQ Playbook"
        />
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