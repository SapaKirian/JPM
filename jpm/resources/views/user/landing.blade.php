<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jaya Perkasa Motor - Dealer Resmi Yamaha</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            scroll-behavior: smooth;
        }

        .glass-nav {
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.8);
        }

        .promo-card {
            transition: all 0.3s ease;
        }

        .promo-card:hover {
            transform: translateY(-10px);
        }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

    <nav class="fixed w-full glass-nav shadow-sm z-50">
        <div class="container mx-auto px-6 py-4 flex justify-between items-center">
            <img src="{{ asset('storage/ASETJPM/LogoYamaha.png') }}" class="h-10 w-auto" alt="Logo">
            <div class="hidden md:flex space-x-8 text-sm font-semibold uppercase tracking-wider">
                <a href="#promo" class="hover:text-blue-600 transition">Promo</a>
                <a href="#produk" class="hover:text-blue-600 transition">Produk</a>
                <a href="#tentang" class="hover:text-blue-600 transition">Tentang</a>
                <a href="#faq" class="hover:text-blue-600 transition">FAQ</a>
                <a href="#kontak"
                    class="bg-blue-700 text-white px-5 py-2 rounded-full hover:bg-blue-800 transition">Hubungi</a>
            </div>
        </div>
    </nav>

    <section class="pt-24 pb-12 px-6">
        <div class="container mx-auto rounded-3xl overflow-hidden shadow-2xl">

            <div class="swiper heroSwiper">
                <div class="swiper-wrapper">

                    <!-- SLIDE 1 - AEROX 155 -->
                    <div class="swiper-slide relative">
                        <img src="{{ asset('storage/ASETJPM/heroimage2.jpg') }}"
                            class="w-full object-cover h-[350px] md:h-[550px]">

                        <div
                            class="absolute inset-0 bg-gradient-to-r from-black/80 to-transparent flex items-center p-10">
                            <div class="text-white max-w-xl">
                                <span class="bg-red-600 px-4 py-1 rounded text-xs font-bold uppercase tracking-widest">
                                    Maxi Sports Scooter
                                </span>

                                <h1 class="text-4xl md:text-6xl font-bold mt-4 italic leading-tight">
                                    ALL NEW AEROX 155 VVA
                                </h1>

                                <p class="text-blue-200 mt-4 text-lg">
                                    Tampil agresif, mesin bertenaga, dan teknologi VVA untuk performa maksimal di setiap
                                    perjalanan.
                                </p>
                            </div>
                        </div>
                    </div>


                    <!-- SLIDE 2 - FAZZIO -->
                    <div class="swiper-slide relative">
                        <img src="{{ asset('storage/ASETJPM/heroimage.jpg') }}"
                            class="w-full object-cover h-[350px] md:h-[550px]">

                        <div
                            class="absolute inset-0 bg-gradient-to-r from-black/70 to-transparent flex items-center p-10">
                            <div class="text-white max-w-xl">
                                <span
                                    class="bg-purple-600 px-4 py-1 rounded text-xs font-bold uppercase tracking-widest">
                                    Classy Hybrid
                                </span>

                                <h1 class="text-4xl md:text-6xl font-bold mt-4 italic">
                                    FAZZIO HYBRID 125
                                </h1>

                                <p class="text-purple-200 mt-4 text-lg">
                                    Go Purple. Go Stylish. Motor hybrid modern untuk generasi aktif dan penuh gaya.
                                </p>
                            </div>
                        </div>
                    </div>


                    <!-- SLIDE 3 - MX KING -->
                    <div class="swiper-slide relative">
                        <img src="{{ asset('storage/ASETJPM/heroimage5.jpg') }}"
                            class="w-full object-cover h-[350px] md:h-[550px]">

                        <div
                            class="absolute inset-0 bg-gradient-to-r from-black/80 to-transparent flex items-center p-10">
                            <div class="text-white max-w-xl">
                                <span class="bg-blue-600 px-4 py-1 rounded text-xs font-bold uppercase tracking-widest">
                                    The King of Street
                                </span>

                                <h1 class="text-4xl md:text-6xl font-bold mt-4 italic">
                                    MX KING 150
                                </h1>

                                <p class="text-blue-200 mt-4 text-lg">
                                    Performa mesin DOHC 150cc dengan desain racing yang siap menaklukkan jalanan kota.
                                </p>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Pagination -->
                <div class="swiper-pagination"></div>

            </div>
        </div>
    </section>

    <section id="promo" class="py-16 bg-white">
        <div class="container mx-auto px-6">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold uppercase italic tracking-tighter text-blue-900">Promo Terkini</h2>
                <p class="text-gray-500 text-sm">Jangan lewatkan kesempatan emas bulan ini!</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <div
                    class="promo-card bg-blue-50 rounded-3xl overflow-hidden border border-blue-100 shadow-sm relative">
                    <div
                        class="absolute top-4 right-4 bg-red-500 text-white font-bold text-xs px-3 py-1 rounded-full z-10 shadow">
                        DP MULAI 700RB
                    </div>

                    <img src="{{ asset('storage/ASETJPM/PROMO1.webp') }}" class="w-full h-48 object-cover">

                    <div class="p-6">
                        <h3 class="font-bold text-xl text-blue-900">Promo Spesial Gear & FreeGo</h3>

                        <p class="text-gray-600 text-sm mt-2">
                            Miliki <strong>Gear 125 DP 700rb</strong> atau
                            <strong>FreeGo DP 1,1jt</strong> sekarang juga!
                            Cicilan ringan dan proses cepat.
                        </p>

                        <hr class="my-4 border-blue-100">

                        <div class="flex justify-between items-center">
                            <span class="text-[10px] text-blue-400 font-bold uppercase tracking-widest">
                                Syarat & Ketentuan Berlaku
                            </span>
                            <a href="https://wa.me/6281321016818?text=Halo%20saya%20tertarik%20Promo%20Gear%20125%20/%20FreeGo%20125.%20Bisa%20info%20lebih%20lanjut%3F"
                                target="_blank"
                                class="bg-blue-700 text-white text-xs font-bold px-4 py-2 rounded-lg hover:bg-blue-800 transition inline-block">
                                Ambil Promo
                            </a>
                        </div>
                    </div>
                </div>

                <div class="promo-card bg-zinc-900 rounded-3xl overflow-hidden shadow-xl relative text-white">
                    <div
                        class="absolute top-4 right-4 bg-red-600 text-white font-bold text-xs px-3 py-1 rounded-full z-10 shadow">
                        DP 1,5JT
                    </div>

                    <img src="{{ asset('storage/ASETJPM/Promo3.webp') }}" class="w-full h-48 object-cover opacity-90">

                    <div class="p-6">
                        <h3 class="font-bold text-xl text-yellow-400">Promo Maxi Series</h3>

                        <p class="text-gray-300 text-sm mt-2">
                            All New Aerox DP <strong>2,3jt</strong> &
                            Lexi LX 155 DP <strong>1,5jt</strong>.
                            Tampil sporty dengan cicilan ringan!
                        </p>

                        <hr class="my-4 border-zinc-700">

                        <div class="flex justify-between items-center">
                            <span class="text-[10px] text-zinc-500 font-bold uppercase tracking-widest">
                                Promo Terbatas
                            </span>
                            <a href="https://wa.me/6281321016818?text=Halo%20saya%20mau%20Promo%20Aerox%20/%20Lexi%20DP%201,5jt.%20Masih%20ada%3F"
                                target="_blank"
                                class="bg-yellow-500 text-zinc-900 text-xs font-bold px-4 py-2 rounded-lg hover:bg-yellow-400 transition inline-block">
                                Hubungi Sales
                            </a>
                        </div>
                    </div>
                </div>

                <div class="promo-card bg-white rounded-3xl overflow-hidden border border-gray-100 shadow-sm relative">
                    <div
                        class="absolute top-4 right-4 bg-purple-600 text-white font-bold text-xs px-3 py-1 rounded-full z-10 shadow">
                        MULAI 700RB
                    </div>

                    <img src="{{ asset('storage/ASETJPM/Promo2.webp') }}" class="w-full h-48 object-cover">

                    <div class="p-6">
                        <h3 class="font-bold text-xl text-gray-800">Fazzio & NMAX Turbo Neo</h3>

                        <p class="text-gray-600 text-sm mt-2">
                            Cukup bayar <strong>700rb-an</strong> untuk Fazzio Hybrid.
                            Atau miliki NMAX Turbo Neo mulai <strong>1,6jt</strong>.
                        </p>

                        <hr class="my-4 border-gray-100">

                        <div class="flex justify-between items-center">
                            <span class="text-[10px] text-gray-400 font-bold uppercase tracking-widest">
                                Modal Jadi Idaman
                            </span>
                            <a href="https://wa.me/6281321016818?text=Halo%20saya%20ingin%20klaim%20Promo%20Fazzio%20/%20NMAX%20Turbo.%20Mohon%20detailnya."
                                target="_blank"
                                class="bg-gray-800 text-white text-xs font-bold px-4 py-2 rounded-lg hover:bg-black transition inline-block">
                                Klaim Sekarang
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="tentang" class="py-20 container mx-auto px-6">
        <div class="grid md:grid-cols-2 gap-12 items-center">
            <div class="relative">
                <div class="absolute -top-4 -left-4 w-24 h-24 bg-blue-100 rounded-full -z-10"></div>
                <img src="{{ asset('storage/ASETJPM/DEALER.jpg') }}"
                    class="rounded-2xl shadow-xl border-4 border-white" alt="Dealer">
            </div>
            <div>
                <h2
                    class="text-3xl font-bold mb-6 text-gray-800 border-l-4 border-blue-700 pl-4 uppercase tracking-tighter italic">
                    Tentang Kami</h2>
                <p class="text-gray-600 leading-relaxed mb-6">
                    Menjadi dealer pilihan utama di masyarakat dengan memberikan pelayanan terbaik dalam penjualan unit,
                    suku cadang, dan perbaikan kendaraan Yamaha Anda. Kami menjamin keaslian dan kualitas nomor satu.
                </p>
                <div class="grid grid-cols-2 gap-4">
                    <div class="p-4 bg-white rounded-xl shadow-sm border border-gray-100">
                        <span class="block text-2xl font-bold text-blue-700">10+</span>
                        <span class="text-xs text-gray-500 uppercase">Tahun Pengalaman</span>
                    </div>
                    <div class="p-4 bg-white rounded-xl shadow-sm border border-gray-100">
                        <span class="block text-2xl font-bold text-blue-700">24/7</span>
                        <span class="text-xs text-gray-500 uppercase">Layanan Konsultasi</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="produk" class="py-20 bg-zinc-900 text-white">
        <div class="container mx-auto px-6">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold uppercase tracking-widest italic">
                    Katalog Produk
                </h2>
                <div class="h-1 w-20 bg-blue-500 mx-auto mt-4"></div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">

                @foreach ([
        [
            'name' => 'MAXI Series',
            'img' => 'maxi.png',
            'desc' => 'Motor premium dengan desain besar, fitur modern, dan kenyamanan maksimal untuk perjalanan jauh maupun harian.',
        ],
        [
            'name' => 'Classy Series',
            'img' => 'classy.png',
            'desc' => 'Skutik retro-modern yang stylish dan ringan, cocok untuk gaya hidup anak muda masa kini.',
        ],
        [
            'name' => 'Sport Series',
            'img' => 'sport.png',
            'desc' => 'Motor performa tinggi dengan desain aerodinamis untuk sensasi berkendara yang agresif.',
        ],
        [
            'name' => 'Matic Series',
            'img' => 'matic.png',
            'desc' => 'Praktis, hemat bahan bakar, dan nyaman untuk mobilitas sehari-hari di perkotaan.',
        ],
        [
            'name' => 'Moped Series',
            'img' => 'moped.png',
            'desc' => 'Motor bebek tangguh dan irit, cocok untuk kebutuhan kerja maupun penggunaan harian.',
        ],
        [
            'name' => 'Off-Road Series',
            'img' => 'off-road.png',
            'desc' => 'Dirancang untuk medan berat dengan suspensi tinggi dan rangka kuat untuk petualangan ekstrem.',
        ],
    ] as $p)
                    <div
                        class="group bg-zinc-800 rounded-3xl overflow-hidden 
                            hover:bg-zinc-700 transition duration-300 
                            border border-zinc-700">

                        <div class="p-4 overflow-hidden">
                            <img src="{{ asset('storage/ASETJPM/' . $p['img']) }}"
                                class="rounded-2xl w-full h-48 object-cover 
                                    group-hover:scale-105 transition duration-500"
                                alt="{{ $p['name'] }}">
                        </div>

                        <div class="p-6">
                            <h3 class="font-bold text-xl mb-2">
                                {{ $p['name'] }}
                            </h3>

                            <p class="text-zinc-400 text-sm mb-6 leading-relaxed">
                                {{ $p['desc'] }}
                            </p>

                            <a href="https://wa.me/6281321016818?text=Saya%20tertarik%20dengan%20{{ urlencode($p['name']) }}"
                                target="_blank"
                                class="block text-center w-full py-3 rounded-xl 
                                  border border-blue-500 text-blue-500 font-bold 
                                  hover:bg-blue-500 hover:text-white 
                                  transition uppercase text-xs tracking-widest">
                                Tanya Sekarang
                            </a>

                        </div>
                    </div>
                @endforeach

            </div>
        </div>
    </section>

    <section id="faq" class="py-20 bg-gray-50">
        <div class="container mx-auto px-6 max-w-4xl">
            <h2 class="text-3xl font-bold text-center mb-12 uppercase italic tracking-tighter text-gray-800">Pertanyaan
                Umum</h2>

            <div class="space-y-4" x-data="{ active: null }">
                @php
                    $faqs = [
                        [
                            'q' => 'Apakah bisa tukar tambah motor lama?',
                            'a' =>
                                'Ya, kami menerima tukar tambah semua merk motor ke motor Yamaha baru dengan harga appraisal yang kompetitif.',
                        ],
                        [
                            'q' => 'Berapa lama proses STNK dan BPKB?',
                            'a' =>
                                'Untuk STNK estimasi 14 hari kerja dan BPKB kurang lebih 3 bulan tergantung wilayah domisili.',
                        ],
                        [
                            'q' => 'Apakah melayani servis kunjungan ke rumah?',
                            'a' =>
                                'Tentu! Kami memiliki layanan Yamaha Diagnostic Tools yang bisa datang langsung ke lokasi Anda.',
                        ],
                        [
                            'q' => 'Apa saja syarat kredit motor?',
                            'a' =>
                                'Cukup siapkan KTP Suami & Istri (jika sudah menikah), Kartu Keluarga, dan bukti penghasilan/Slip Gaji.',
                        ],
                    ];
                @endphp

                @foreach ($faqs as $index => $faq)
                    <div
                        class="border border-gray-200 rounded-2xl bg-white overflow-hidden shadow-sm transition-all duration-300">
                        <button
                            @click="active !== {{ $index }} ? active = {{ $index }} : active = null"
                            class="w-full flex justify-between items-center p-6 text-left font-semibold text-gray-700 hover:bg-blue-50 transition">
                            <span class="text-sm md:text-base">{{ $faq['q'] }}</span>
                            <svg class="w-5 h-5 transition-transform duration-300 text-blue-600"
                                :class="active === {{ $index }} ? 'rotate-180' : ''" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </button>
                        <div x-show="active === {{ $index }}" x-collapse
                            class="p-6 text-gray-600 text-sm border-t border-gray-100 bg-gray-50"
                            style="display: none;">
                            {{ $faq['a'] }}
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </section>

    <footer id="kontak" class="bg-blue-950 text-white pt-20 pb-10">
        <div class="container mx-auto px-6 grid grid-cols-1 md:grid-cols-4 gap-12 border-b border-blue-900 pb-12">
            <div class="col-span-1 md:col-span-2">
                <h3 class="text-2xl font-bold mb-6 italic uppercase tracking-tighter">Jaya Perkasa Motor</h3>
                <p class="text-blue-200 mb-6 max-w-md italic font-light">
                    "Kualitas adalah prioritas kami dalam memberikan kepuasan berkendara bagi Anda."
                </p>
                <div class="flex space-x-4">

                    <!-- Instagram -->
                    <a href="https://instagram.com/username_kamu" target="_blank"
                        class="w-10 h-10 bg-blue-800 rounded-full flex items-center justify-center hover:bg-blue-600 transition shadow-lg">
                        IG
                    </a>

                    <!-- Facebook -->
                    <a href="https://facebook.com/username_kamu" target="_blank"
                        class="w-10 h-10 bg-blue-800 rounded-full flex items-center justify-center hover:bg-blue-600 transition shadow-lg">
                        FB
                    </a>

                    <!-- WhatsApp -->
                    <a href="https://wa.me/6281321016818" target="_blank"
                        class="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center hover:bg-green-600 transition shadow-lg">
                        WA
                    </a>

                </div>
            </div>
            <div>
                <h4 class="font-bold mb-6 uppercase text-sm tracking-widest text-blue-400">Jam Operasional</h4>
                <ul class="text-sm text-blue-200 space-y-2">
                    <li>Senin - Jumat: 08:00 - 17:00</li>
                    <li>Sabtu: 08:00 - 15:00</li>
                    <li>Minggu: Libur</li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-6 uppercase text-sm tracking-widest text-blue-400">Hubungi Kami</h4>
                <p class="text-sm text-blue-200 italic">Situraja, Kec. Situraja, Kabupaten Sumedang, Jawa Barat 45371
                </p>
                <p class="text-lg font-bold mt-2 text-white">0813-2101-6818</p>
            </div>
        </div>
        <p class="text-center mt-10 text-xs text-blue-400 font-light tracking-widest">
            &copy; 2026 JAYA PERKASA MOTOR. AUTHORIZED YAMAHA DEALER.
        </p>
    </footer>
    <style>
        /* Supaya slide yang tidak aktif benar-benar hilang */
        .swiper-slide {
            opacity: 0 !important;
            transition: opacity 0.8s ease;
        }

        .swiper-slide-active {
            opacity: 1 !important;
        }
    </style>
    <script>
        const swiper = new Swiper(".heroSwiper", {
            loop: true,
            effect: "fade",
            fadeEffect: {
                crossFade: true
            },
            autoplay: {
                delay: 4000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
        });
    </script>
</body>

</html>
