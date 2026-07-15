import { computed, reactive } from 'vue'

export type Locale = 'zh' | 'en' | 'hi' | 'de'

const localeLabels: Record<Locale, string> = {
  zh: '中文',
  en: 'EN',
  hi: 'हिन्दी',
  de: 'DE',
}

const state = reactive({
  locale: (localStorage.getItem('site_locale') as Locale) || 'zh',
})

export const currentLocale = computed(() => state.locale)
export const languages = Object.entries(localeLabels).map(([value, label]) => ({ value: value as Locale, label }))

export function setLocale(locale: Locale) {
  state.locale = locale
  localStorage.setItem('site_locale', locale)
}

export const dict = {
  zh: {
    nav: { home: '首页', company: '关于我们', products: '产品中心', contact: '联系我们' },
    brand: '恒展五金科技',
    cta1688: '1688在线验厂',
    viewFactory: '查看14年金牌工厂实拍',
    allProducts: '全部产品',
    hero: {
      eyebrow: 'HENGZHAN HEATSINK FACTORY',
      title: '20余年深耕散热器行业的源头工厂',
      subtitle: '深圳市恒展五金科技有限公司，2012年成立，专注铝型材散热器及各类电子散热产品生产加工，是阿里巴巴诚信14年金牌商家。',
    },
    metrics: [
      { label: '行业深耕', value: '20余年' },
      { label: '成立时间', value: '2012年' },
      { label: '诚信通商家', value: '14年' },
      { label: '生产加工', value: '十余年' },
    ],
    about: {
      eyebrow: 'ABOUT HENGZHAN',
      title: '把老客户愿意复购的稳定性，做进每一批散热产品',
      p1: '深圳市恒展五金科技有限公司成立于2012年，长期专注铝型材散热器、电子散热片及各类设备散热产品的生产加工。公司深耕散热器行业20余年，以源头工厂身份服务B端采购、工程开发与供应链配套需求。',
      p2: '对于采购商和工程师而言，散热产品不只看样品，更看批量交付时的尺寸一致性、加工稳定性与沟通效率。恒展五金依托十余年生产加工经验，围绕来图加工、结构适配、批量生产与持续供货积累了大量老客户口碑。',
      p3: '同时，公司是阿里巴巴诚信14年金牌商家，采购方可通过1688店铺进一步核验工厂信息、沟通需求并快速拿样。',
    },
    productTitle: '产品中心',
    filter: '筛选',
    productLabels: { material: '材质', method: '加工方式', covered: '覆盖产品', cooperation: '合作方式', value: '采购价值' },
    products: [
      { name: '工业设备散热', summary: '覆盖LED散热器、服务器散热器、液压一体散热器，面向连续运行设备的稳定散热需求。', material: '铝型材', method: '按图加工', covered: 'LED散热器、服务器散热器、液压一体散热器', value: '面向连续运行设备的稳定散热需求，重视结构强度、导热效率与批量一致性。' },
      { name: '消费电子散热', summary: '覆盖电脑散热器、电子散热片、CPU风冷散热器、PC风扇，适配整机装配与批量采购。', material: '铝型材', method: '批量加工', covered: '电脑散热器、电子散热片、CPU风冷散热器、PC风扇', value: '适配整机装配、工程打样和批量采购，帮助客户平衡散热性能与装配效率。' },
      { name: '精密医疗/美容散热', summary: '覆盖美容仪散热产品、医疗设备散热产品，重视结构适配、外观一致性与长期供货稳定性。', material: '铝型材', method: '来图定制', covered: '美容仪散热产品、医疗设备散热产品', value: '关注结构适配、外观一致性与长期供货稳定性，适合设备类产品配套。' },
    ],
    whyTitle: '为什么选择我们',
    why: [
      { title: '源头工厂，沟通更直接', text: '围绕铝型材散热器及电子散热产品生产加工，减少中间沟通损耗，更适合工程打样与批量采购衔接。' },
      { title: '14年诚信通记录可核验', text: '通过1688店铺沉淀长期经营记录，让采购方在下单前多一层可验证的信任依据。' },
      { title: '实体地址清晰可追溯', text: '工厂地址位于中国广东省东莞市黄江镇合路村创业三路11号芙光科技园B座1楼。' },
      { title: '老客户口碑验证', text: '长期服务复购客户，靠稳定加工、务实沟通和持续供货建立合作基础。' },
    ],
    partners: ['铝型材散热器', '电脑散热器', '电子散热片', 'CPU风冷散热器', 'PC风扇', 'LED散热器', '服务器散热器', '液压一体散热器'],
    company: {
      title: '深圳市恒展五金科技有限公司',
      lead: '成立于2012年，深耕散热器行业20余年，是阿里巴巴诚信14年金牌商家。',
      story1: '恒展五金长期专注铝型材散热器、电子散热片及各类设备散热产品生产加工。对B端采购商、工程师和供应链负责人来说，散热件不是一次性买卖，而是需要稳定打样、稳定量产、稳定沟通的长期配套。',
      story2: '公司凭借十余年生产加工经验，在来图加工、结构适配、批量交付与持续供货中积累了老客户口碑。我们不做空泛承诺，而是把客户关心的工厂真实性、交付稳定性和产品适配沟通放在合作前面。',
      timeline: ['2012年 公司成立', '十余年 铝型材散热器生产加工经验', '14年 阿里巴巴诚信金牌商家', '老客户口碑 长期复购验证稳定性'],
    },
    contact: {
      title: '联系我们',
      lead: '工厂地址：中国广东省东莞市黄江镇合路村创业三路11号芙光科技园B座1楼',
      addressTitle: '实体工厂地址',
      address: '中国广东省东莞市黄江镇合路村创业三路11号芙光科技园B座1楼',
      company: '公司名称',
      name: '联系人',
      phone: '联系电话',
      email: '邮箱',
      message: '请描述散热产品类型、图纸、数量或交付需求',
      submit: '提交留言',
      sample: '1688在线验厂 / 快速拿样',
    },
  },
  en: {
    nav: { home: 'Home', company: 'About', products: 'Products', contact: 'Contact' },
    brand: 'HengZhan Hardware',
    cta1688: 'Verify on 1688',
    viewFactory: 'View 14-Year Gold Supplier',
    allProducts: 'All Products',
    hero: { eyebrow: 'HENGZHAN HEATSINK FACTORY', title: 'A source factory focused on heat sinks for over 20 years', subtitle: 'Shenzhen HengZhan Hardware Technology Co., Ltd. was founded in 2012, specializing in aluminum profile heat sinks and electronic thermal products. It is a 14-year Alibaba Gold Supplier.' },
    metrics: [{ label: 'Industry Focus', value: '20+ Years' }, { label: 'Founded', value: '2012' }, { label: 'Alibaba Gold', value: '14 Years' }, { label: 'Manufacturing', value: '10+ Years' }],
    about: { eyebrow: 'ABOUT HENGZHAN', title: 'Stable repeat orders begin with stable heat sink manufacturing', p1: 'Founded in 2012, Shenzhen HengZhan Hardware Technology Co., Ltd. focuses on aluminum heat sinks, electronic heat sink plates and thermal products for equipment. With over 20 years in the heat sink industry, HengZhan serves B2B procurement, engineering development and supply chain needs as a source factory.', p2: 'For buyers and engineers, heat sinks are judged not only by samples but by dimensional consistency, production stability and communication efficiency in volume delivery. HengZhan has built long-term customer trust through drawing-based machining, structural adaptation, batch production and continuous supply.', p3: 'The company is also a 14-year Alibaba Gold Supplier, allowing buyers to verify factory information, discuss requirements and request samples through its 1688 store.' },
    productTitle: 'Product Center',
    filter: 'Filter',
    productLabels: { material: 'Material', method: 'Process', covered: 'Products', cooperation: 'Mode', value: 'Value' },
    products: [
      { name: 'Industrial Equipment Cooling', summary: 'LED heat sinks, server heat sinks and hydraulic integrated radiators for stable thermal performance in continuous operation.', material: 'Aluminum profile', method: 'Made to drawing', covered: 'LED heat sinks, server heat sinks, hydraulic integrated radiators', value: 'Built for continuous equipment operation, focusing on structure, thermal efficiency and batch consistency.' },
      { name: 'Consumer Electronics Cooling', summary: 'Computer heat sinks, electronic heat sink plates, CPU air coolers and PC fans for assembly and batch procurement.', material: 'Aluminum profile', method: 'Batch machining', covered: 'Computer heat sinks, electronic heat sink plates, CPU air coolers, PC fans', value: 'Supports engineering samples and production purchasing while balancing thermal performance and assembly efficiency.' },
      { name: 'Medical & Beauty Device Cooling', summary: 'Cooling products for beauty instruments and medical equipment with emphasis on fit, appearance consistency and stable supply.', material: 'Aluminum profile', method: 'Custom to drawing', covered: 'Beauty instrument cooling products, medical equipment cooling products', value: 'Suitable for equipment integration with focus on structural fit, finish consistency and long-term supply.' },
    ],
    whyTitle: 'Why Choose Us',
    why: [{ title: 'Source factory, direct communication', text: 'Focused production of aluminum profile heat sinks and electronic thermal products reduces communication loss between engineering and procurement.' }, { title: '14-year Alibaba record', text: 'The 1688 store provides a verifiable long-term operating record before purchase.' }, { title: 'Traceable physical address', text: 'Factory address: 1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China.' }, { title: 'Repeat-customer reputation', text: 'Stable machining, practical communication and continuous supply support long-term cooperation.' }],
    partners: ['Aluminum Heat Sinks', 'Computer Heat Sinks', 'Electronic Heat Sink Plates', 'CPU Air Coolers', 'PC Fans', 'LED Heat Sinks', 'Server Heat Sinks', 'Hydraulic Radiators'],
    company: { title: 'Shenzhen HengZhan Hardware Technology Co., Ltd.', lead: 'Founded in 2012, focused on heat sinks for over 20 years, and a 14-year Alibaba Gold Supplier.', story1: 'HengZhan focuses on aluminum profile heat sinks, electronic heat sink plates and thermal products for equipment. For B2B buyers, engineers and supply chain teams, heat sinks require stable sampling, stable mass production and stable communication.', story2: 'With over ten years of manufacturing experience, the company has built repeat-customer reputation through drawing-based machining, structural adaptation, batch delivery and continuous supply.', timeline: ['2012 Company founded', '10+ years aluminum heat sink machining', '14-year Alibaba Gold Supplier', 'Repeat orders validate stability'] },
    contact: { title: 'Contact Us', lead: 'Factory address: 1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China', addressTitle: 'Physical Factory Address', address: '1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China', company: 'Company', name: 'Contact Name', phone: 'Phone', email: 'Email', message: 'Describe product type, drawings, quantity or delivery needs', submit: 'Submit', sample: 'Verify on 1688 / Request Samples' },
  },
  hi: {
    nav: { home: 'होम', company: 'हमारे बारे में', products: 'उत्पाद', contact: 'संपर्क' },
    brand: 'HengZhan Hardware',
    cta1688: '1688 पर सत्यापन',
    viewFactory: '14-वर्ष गोल्ड सप्लायर देखें',
    allProducts: 'सभी उत्पाद',
    hero: { eyebrow: 'HENGZHAN HEATSINK FACTORY', title: '20+ वर्षों से हीट सिंक उद्योग में केंद्रित स्रोत कारखाना', subtitle: 'Shenzhen HengZhan Hardware Technology Co., Ltd. 2012 में स्थापित हुई, एल्यूमिनियम प्रोफाइल हीट सिंक और इलेक्ट्रॉनिक थर्मल उत्पादों में विशेषज्ञ है, और 14-वर्ष Alibaba Gold Supplier है।' },
    metrics: [{ label: 'उद्योग अनुभव', value: '20+ वर्ष' }, { label: 'स्थापना', value: '2012' }, { label: 'Alibaba Gold', value: '14 वर्ष' }, { label: 'उत्पादन', value: '10+ वर्ष' }],
    about: { eyebrow: 'ABOUT HENGZHAN', title: 'हर बैच में स्थिरता, ताकि ग्राहक दोबारा ऑर्डर करें', p1: '2012 में स्थापित HengZhan एल्यूमिनियम हीट सिंक, इलेक्ट्रॉनिक हीट सिंक प्लेट और उपकरणों के थर्मल उत्पादों पर केंद्रित है। 20+ वर्षों के उद्योग अनुभव के साथ यह B2B खरीद, इंजीनियरिंग और सप्लाई चेन जरूरतों को स्रोत कारखाने के रूप में सेवा देता है।', p2: 'खरीदारों और इंजीनियरों के लिए नमूने से अधिक महत्वपूर्ण है बड़े पैमाने पर डिलीवरी में माप की स्थिरता, प्रोसेस स्थिरता और संचार दक्षता।', p3: 'कंपनी 14-वर्ष Alibaba Gold Supplier है, जिससे खरीदार 1688 स्टोर पर फैक्टरी जानकारी सत्यापित कर सकते हैं और नमूना मांग सकते हैं।' },
    productTitle: 'उत्पाद केंद्र',
    filter: 'फ़िल्टर',
    productLabels: { material: 'सामग्री', method: 'प्रक्रिया', covered: 'उत्पाद', cooperation: 'मोड', value: 'खरीद मूल्य' },
    products: [
      { name: 'औद्योगिक उपकरण कूलिंग', summary: 'LED, सर्वर और हाइड्रोलिक रेडिएटर के लिए स्थिर थर्मल समाधान।', material: 'एल्यूमिनियम प्रोफाइल', method: 'ड्राइंग के अनुसार', covered: 'LED heat sinks, server heat sinks, hydraulic radiators', value: 'लगातार चलने वाले उपकरणों के लिए संरचना, ताप दक्षता और बैच स्थिरता पर ध्यान।' },
      { name: 'कंज्यूमर इलेक्ट्रॉनिक्स कूलिंग', summary: 'कंप्यूटर हीट सिंक, CPU air coolers, PC fans और electronic heat sink plates।', material: 'एल्यूमिनियम प्रोफाइल', method: 'बैच प्रोसेसिंग', covered: 'Computer heat sinks, electronic heat sink plates, CPU air coolers, PC fans', value: 'इंजीनियरिंग नमूने और बैच खरीद में थर्मल प्रदर्शन और असेंबली दक्षता का संतुलन।' },
      { name: 'मेडिकल/ब्यूटी डिवाइस कूलिंग', summary: 'Beauty instruments और medical equipment के cooling products।', material: 'एल्यूमिनियम प्रोफाइल', method: 'कस्टम ड्राइंग', covered: 'Beauty instrument cooling products, medical equipment cooling products', value: 'संरचनात्मक फिट, appearance consistency और long-term supply पर ध्यान।' },
    ],
    whyTitle: 'हमें क्यों चुनें',
    why: [{ title: 'Source factory, direct communication', text: 'एल्यूमिनियम heat sinks और thermal products में केंद्रित उत्पादन, engineering और procurement के बीच communication loss कम करता है।' }, { title: '14-वर्ष Alibaba record', text: '1688 store खरीद से पहले लंबे संचालन रिकॉर्ड को सत्यापित करने में मदद करता है।' }, { title: 'Traceable physical address', text: 'Factory address: 1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China.' }, { title: 'Repeat-customer reputation', text: 'Stable machining, practical communication और continuous supply लंबे सहयोग का आधार है।' }],
    partners: ['Aluminum Heat Sinks', 'Computer Heat Sinks', 'Electronic Heat Sink Plates', 'CPU Air Coolers', 'PC Fans', 'LED Heat Sinks', 'Server Heat Sinks', 'Hydraulic Radiators'],
    company: { title: 'Shenzhen HengZhan Hardware Technology Co., Ltd.', lead: '2012 में स्थापित, 20+ वर्षों से heat sink industry पर केंद्रित, 14-वर्ष Alibaba Gold Supplier.', story1: 'HengZhan aluminum profile heat sinks, electronic heat sink plates और thermal products पर केंद्रित है। B2B buyers और engineers के लिए stable samples, stable mass production और stable communication आवश्यक हैं।', story2: '10+ वर्षों के manufacturing experience से कंपनी drawing-based machining, structural adaptation, batch delivery और continuous supply में repeat customer reputation बनाती है।', timeline: ['2012 Company founded', '10+ years aluminum heat sink machining', '14-year Alibaba Gold Supplier', 'Repeat orders validate stability'] },
    contact: { title: 'संपर्क करें', lead: 'Factory address: 1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China', addressTitle: 'Physical Factory Address', address: '1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China', company: 'Company', name: 'Contact Name', phone: 'Phone', email: 'Email', message: 'Product type, drawings, quantity or delivery needs', submit: 'Submit', sample: 'Verify on 1688 / Request Samples' },
  },
  de: {
    nav: { home: 'Start', company: 'Über uns', products: 'Produkte', contact: 'Kontakt' },
    brand: 'HengZhan Hardware',
    cta1688: 'Auf 1688 prüfen',
    viewFactory: '14 Jahre Gold-Lieferant ansehen',
    allProducts: 'Alle Produkte',
    hero: { eyebrow: 'HENGZHAN HEATSINK FACTORY', title: 'Quellfabrik für Kühlkörper mit über 20 Jahren Branchenerfahrung', subtitle: 'Shenzhen HengZhan Hardware Technology Co., Ltd. wurde 2012 gegründet und spezialisiert sich auf Aluminiumprofil-Kühlkörper und elektronische Wärmeableitungsprodukte. Das Unternehmen ist seit 14 Jahren Alibaba Gold Supplier.' },
    metrics: [{ label: 'Branchenerfahrung', value: '20+ Jahre' }, { label: 'Gegründet', value: '2012' }, { label: 'Alibaba Gold', value: '14 Jahre' }, { label: 'Fertigung', value: '10+ Jahre' }],
    about: { eyebrow: 'ABOUT HENGZHAN', title: 'Stabile Fertigung für wiederkehrende Kundenaufträge', p1: 'HengZhan wurde 2012 gegründet und konzentriert sich langfristig auf Aluminium-Kühlkörper, elektronische Kühlplatten und thermische Produkte für Geräte. Als Quellfabrik unterstützt HengZhan Einkauf, Engineering und Lieferketten.', p2: 'Für Einkäufer und Ingenieure zählen nicht nur Muster, sondern Maßhaltigkeit, Prozessstabilität und effiziente Kommunikation in der Serienlieferung.', p3: 'Als 14-jähriger Alibaba Gold Supplier ermöglicht der 1688-Shop die Prüfung der Fabrikinformationen und eine schnelle Musteranfrage.' },
    productTitle: 'Produktzentrum',
    filter: 'Filter',
    productLabels: { material: 'Material', method: 'Prozess', covered: 'Produkte', cooperation: 'Modus', value: 'Nutzen' },
    products: [
      { name: 'Kühlung für Industrieanlagen', summary: 'LED-Kühlkörper, Server-Kühlkörper und hydraulische Radiatoren für stabilen Betrieb.', material: 'Aluminiumprofil', method: 'Nach Zeichnung', covered: 'LED-Kühlkörper, Server-Kühlkörper, hydraulische Radiatoren', value: 'Für Dauerbetrieb mit Fokus auf Struktur, Wärmeeffizienz und Serienkonstanz.' },
      { name: 'Kühlung für Unterhaltungselektronik', summary: 'Computer-Kühlkörper, elektronische Kühlplatten, CPU-Luftkühler und PC-Lüfter.', material: 'Aluminiumprofil', method: 'Serienbearbeitung', covered: 'Computer-Kühlkörper, elektronische Kühlplatten, CPU-Luftkühler, PC-Lüfter', value: 'Unterstützt Musterbau und Serienbeschaffung bei ausgewogenem Verhältnis aus Wärmeleistung und Montageeffizienz.' },
      { name: 'Kühlung für Medizin- und Beautygeräte', summary: 'Kühlprodukte für Beauty-Instrumente und medizinische Geräte mit stabiler Versorgung.', material: 'Aluminiumprofil', method: 'Kundenspezifisch nach Zeichnung', covered: 'Beauty instrument cooling products, medical equipment cooling products', value: 'Fokus auf strukturelle Passung, einheitliche Optik und langfristige Lieferung.' },
    ],
    whyTitle: 'Warum wir',
    why: [{ title: 'Quellfabrik, direkte Kommunikation', text: 'Fokussierte Fertigung von Aluminium-Kühlkörpern und thermischen Produkten reduziert Abstimmungsverluste.' }, { title: '14 Jahre Alibaba-Nachweis', text: 'Der 1688-Shop bietet vor dem Einkauf einen prüfbaren Geschäftsverlauf.' }, { title: 'Nachverfolgbare Adresse', text: 'Factory address: 1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China.' }, { title: 'Ruf durch Stammkunden', text: 'Stabile Bearbeitung, pragmatische Kommunikation und kontinuierliche Lieferung bilden die Grundlage langfristiger Zusammenarbeit.' }],
    partners: ['Aluminum Heat Sinks', 'Computer Heat Sinks', 'Electronic Heat Sink Plates', 'CPU Air Coolers', 'PC Fans', 'LED Heat Sinks', 'Server Heat Sinks', 'Hydraulic Radiators'],
    company: { title: 'Shenzhen HengZhan Hardware Technology Co., Ltd.', lead: 'Gegründet 2012, über 20 Jahre Fokus auf Kühlkörper, 14 Jahre Alibaba Gold Supplier.', story1: 'HengZhan konzentriert sich auf Aluminiumprofil-Kühlkörper, elektronische Kühlplatten und thermische Produkte. Für B2B-Einkäufer und Ingenieure sind stabile Muster, stabile Serienfertigung und stabile Kommunikation entscheidend.', story2: 'Mit mehr als zehn Jahren Fertigungserfahrung hat das Unternehmen Vertrauen durch zeichnungsbasierte Bearbeitung, strukturelle Anpassung, Serienlieferung und kontinuierliche Versorgung aufgebaut.', timeline: ['2012 gegründet', '10+ Jahre Aluminium-Kühlkörperbearbeitung', '14 Jahre Alibaba Gold Supplier', 'Wiederholaufträge belegen Stabilität'] },
    contact: { title: 'Kontakt', lead: 'Factory address: 1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China', addressTitle: 'Physische Fabrikadresse', address: '1F, Building B, Fuguang Technology Park, No. 11 Chuangye 3rd Road, Helu Village, Huangjiang Town, Dongguan City, Guangdong, China', company: 'Firma', name: 'Kontaktperson', phone: 'Telefon', email: 'E-Mail', message: 'Produkttyp, Zeichnungen, Menge oder Lieferbedarf beschreiben', submit: 'Senden', sample: 'Auf 1688 prüfen / Muster anfragen' },
  },
} as const

export const t = computed(() => dict[state.locale])
